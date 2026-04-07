/* -----------------------------------------------------------
   ETERNAL CURRENTS — HIGH‑RES VISUALIZATION ENGINE
   Four Layouts · Physics Engine · Rendering · Zoom · Drag
----------------------------------------------------------- */

const EC = {};
EC.nodes = window.EC_DATA.nodes;
EC.links = window.EC_DATA.links;

EC.svg = d3.select("#viz");
EC.container = document.getElementById("vizContainer");

function resizeSvg() {
  const rect = EC.container.getBoundingClientRect();
  EC.svg.attr("width", rect.width).attr("height", rect.height);
}
window.addEventListener("resize", resizeSvg);
resizeSvg();

/* -----------------------------------------------------------
   COLOR + WIDTH HELPERS
----------------------------------------------------------- */
EC.colorByType = (type) => {
  const root = getComputedStyle(document.documentElement);
  if (type === "parent") return root.getPropertyValue("--parent").trim();
  if (type === "self") return root.getPropertyValue("--self").trim();
  return root.getPropertyValue("--other").trim();
};

EC.linkColor = (d) => {
  const root = getComputedStyle(document.documentElement);
  return d.kind === "core"
    ? root.getPropertyValue("--link-strong").trim()
    : root.getPropertyValue("--link").trim();
};

EC.linkWidth = (d) => (d.kind === "core" ? 2.2 : 1.2);

/* -----------------------------------------------------------
   FORCE SIMULATION
----------------------------------------------------------- */
EC.simulation = d3.forceSimulation(EC.nodes);

/* -----------------------------------------------------------
   RENDERING LAYERS
----------------------------------------------------------- */
EC.svg.selectAll("*").remove();
EC.zoomLayer = EC.svg.append("g").attr("class", "zoom-layer");

EC.linkGroup = EC.zoomLayer.append("g").attr("class", "links");
EC.nodeGroup = EC.zoomLayer.append("g").attr("class", "nodes");
EC.labelGroup = EC.zoomLayer.append("g").attr("class", "labels");

/* -----------------------------------------------------------
   LINKS
----------------------------------------------------------- */
EC.linkSelection = EC.linkGroup
  .selectAll("line")
  .data(EC.links)
  .enter()
  .append("line")
  .attr("stroke", EC.linkColor)
  .attr("stroke-width", EC.linkWidth)
  .attr("stroke-linecap", "round")
  .attr("opacity", 0.9);

/* -----------------------------------------------------------
   NODES
----------------------------------------------------------- */
EC.nodeSelection = EC.nodeGroup
  .selectAll("circle")
  .data(EC.nodes)
  .enter()
  .append("circle")
  .attr("r", 16)
  .attr("fill", (d) => EC.colorByType(d.type))
  .attr("stroke", "#05060a")
  .attr("stroke-width", 1.4)
  .style("cursor", "pointer")
  .on("click", (event, d) => {
    event.stopPropagation();
    window.EC_UI.setSelectedNode(d);
  })
  .call(
    d3
      .drag()
      .on("start", (event, d) => {
        if (!event.active) EC.simulation.alphaTarget(0.3).restart();
        d.fx = d.x;
        d.fy = d.y;
      })
      .on("drag", (event, d) => {
        d.fx = event.x;
        d.fy = event.y;
      })
      .on("end", (event, d) => {
        if (!event.active) EC.simulation.alphaTarget(0);
      })
  );

/* -----------------------------------------------------------
   LABELS
----------------------------------------------------------- */
EC.labelSelection = EC.labelGroup
  .selectAll("text")
  .data(EC.nodes)
  .enter()
  .append("text")
  .text((d) => d.label)
  .attr("font-size", 11)
  .attr("fill", "#f7f7f7")
  .attr("text-anchor", "middle")
  .attr("dy", 28)
  .style("pointer-events", "none");

/* -----------------------------------------------------------
   ZOOM
----------------------------------------------------------- */
EC.svg.call(
  d3
    .zoom()
    .scaleExtent([0.4, 2.5])
    .on("zoom", (event) => {
      EC.zoomLayer.attr("transform", event.transform);
    })
);

/* -----------------------------------------------------------
   LAYOUT HELPERS
----------------------------------------------------------- */
EC.clearFixed = () => {
  EC.nodes.forEach((n) => {
    n.fx = null;
    n.fy = null;
  });
};

EC.applyHybrid = () => {
  const rect = EC.container.getBoundingClientRect();
  const cx = rect.width / 2;
  const cy = rect.height / 2;

  EC.simulation
    .force("charge", d3.forceManyBody().strength(-260))
    .force("center", d3.forceCenter(cx, cy))
    .force(
      "link",
      d3
        .forceLink(EC.links)
        .id((d) => d.id)
        .distance((d) => (d.kind === "core" ? 90 : 130))
    )
    .force("collision", d3.forceCollide().radius(40))
    .alpha(1)
    .restart();
};

EC.applyRadial = () => {
  const rect = EC.container.getBoundingClientRect();
  const cx = rect.width / 2;
  const cy = rect.height / 2;

  const centerNode = EC.nodes.find((n) => n.id === "ME") || EC.nodes[0];
  const others = EC.nodes.filter((n) => n.id !== centerNode.id);

  const radius = Math.min(rect.width, rect.height) / 2.4;
  others.forEach((node, i) => {
    const angle = (2 * Math.PI * i) / others.length;
    node.fx = cx + radius * Math.cos(angle);
    node.fy = cy + radius * Math.sin(angle);
  });

  centerNode.fx = cx;
  centerNode.fy = cy;

  EC.simulation
    .force("charge", d3.forceManyBody().strength(-80))
    .force("center", d3.forceCenter(cx, cy))
    .force(
      "link",
      d3.forceLink(EC.links).id((d) => d.id).distance(140)
    )
    .force("collision", d3.forceCollide().radius(40))
    .alpha(1)
    .restart();
};

EC.applyLinear = () => {
  const rect = EC.container.getBoundingClientRect();
  const cx = rect.width / 2;
  const cy = rect.height / 2;

  const sorted = [...EC.nodes];
  const selfIndex = sorted.findIndex((n) => n.id === "ME");
  if (selfIndex > -1) {
    const [selfNode] = sorted.splice(selfIndex, 1);
    sorted.unshift(selfNode);
  }

  const spacing = rect.width / (sorted.length + 1);
  sorted.forEach((node, i) => {
    node.fx = spacing * (i + 1);
    node.fy = cy;
  });

  EC.simulation
    .force("charge", d3.forceManyBody().strength(-40))
    .force("center", null)
    .force(
      "link",
      d3.forceLink(EC.links).id((d) => d.id).distance(120)
    )
    .force("collision", d3.forceCollide().radius(40))
    .alpha(1)
    .restart();
};

EC.applyCluster = () => {
  const rect = EC.container.getBoundingClientRect();
  const cx = rect.width / 2;
  const cy = rect.height / 2;

  const clusters = { parent: [], self: [], other: [] };
  EC.nodes.forEach((n) => clusters[n.type].push(n));

  const centers = {
    parent: { x: cx - rect.width / 4, y: cy - 40 },
    self: { x: cx, y: cy + 40 },
    other: { x: cx + rect.width / 4, y: cy - 40 }
  };

  Object.entries(clusters).forEach(([type, group]) => {
    const center = centers[type];
    const radius = 70;
    group.forEach((node, i) => {
      const angle = (2 * Math.PI * i) / Math.max(group.length, 1);
      node.fx = center.x + radius * Math.cos(angle);
      node.fy = center.y + radius * Math.sin(angle);
    });
  });

  EC.simulation
    .force("charge", d3.forceManyBody().strength(-40))
    .force("center", d3.forceCenter(cx, cy))
    .force(
      "link",
      d3.forceLink(EC.links).id((d) => d.id).distance(110)
    )
    .force("collision", d3.forceCollide().radius(40))
    .alpha(1)
    .restart();
};

/* -----------------------------------------------------------
   APPLY LAYOUT
----------------------------------------------------------- */
EC.applyLayout = (layout) => {
  EC.clearFixed();

  if (layout === "hybrid") EC.applyHybrid();
  else if (layout === "radial") EC.applyRadial();
  else if (layout === "linear") EC.applyLinear();
  else if (layout === "cluster") EC.applyCluster();
};

/* -----------------------------------------------------------
   TICK UPDATE
----------------------------------------------------------- */
EC.simulation.on("tick", () => {
  EC.linkSelection
    .attr("x1", (d) => d.source.x)
    .attr("y1", (d) => d.source.y)
    .attr("x2", (d) => d.target.x)
    .attr("y2", (d) => d.target.y);

  EC.nodeSelection
    .attr("cx", (d) => d.x)
    .attr("cy", (d) => d.y);

  EC.labelSelection
    .attr("x", (d) => d.x)
    .attr("y", (d) => d.y);
});

/* -----------------------------------------------------------
   INITIAL LAYOUT
----------------------------------------------------------- */
EC.applyLayout("hybrid");