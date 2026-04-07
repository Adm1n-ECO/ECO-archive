/* ============================================================
   DATASET — best-guess from your diagram
============================================================ */

const RAW_NODES = [
  { id: "ME", name: "Me", role: "Self" },
  { id: "W", name: "My Wife", role: "Partner" },
  { id: "S", name: "My Son", role: "Child" },

  { id: "B1", name: "Brother's Dad", role: "Parent" },
  { id: "M1", name: "Biological Mom", role: "Parent" },

  { id: "NV", name: "NV", role: "Grandparent" },
  { id: "DP", name: "DP", role: "Grandparent" },

  { id: "PB", name: "PB", role: "Grandparent" },
  { id: "RS", name: "RS", role: "Grandparent" },
  { id: "KS", name: "KS", role: "Grandparent" }
];

const RAW_RELATIONSHIPS = [
  { source: "ME", target: "W", type: "partner" },

  { source: "ME", target: "B1", type: "parent" },
  { source: "ME", target: "M1", type: "parent" },

  { source: "W", target: "S", type: "parent" },
  { source: "ME", target: "S", type: "parent" },

  { source: "B1", target: "NV", type: "parent" },
  { source: "B1", target: "DP", type: "parent" },

  { source: "M1", target: "PB", type: "parent" },
  { source: "M1", target: "RS", type: "parent" },
  { source: "M1", target: "KS", type: "parent" }
];

/* ============================================================
   GLOBAL STATE
============================================================ */

let canvas, ctx;
let simulationNodes = [];
let simulationLinks = [];
let currentStyle = "hybrid";

const STYLE_PRESETS = {
  hybrid: { centerForce: 0.02, linkStrength: 0.05, repulsion: 1200 },
  radial: { centerForce: 0.03, linkStrength: 0.04, repulsion: 900 },
  linear: { centerForce: 0.01, linkStrength: 0.06, repulsion: 1000 },
  cluster: { centerForce: 0.02, linkStrength: 0.08, repulsion: 800 }
};

/* ============================================================
   INITIALIZATION
============================================================ */

function resizeCanvas() {
  const container = document.getElementById("visualization_container");
  if (!container || !canvas) return;
  canvas.width = container.clientWidth;
  canvas.height = container.clientHeight;
}

function initializeSimulation() {
  simulationNodes = RAW_NODES.map(n => ({
    ...n,
    x: Math.random() * (canvas.width || 800),
    y: Math.random() * (canvas.height || 600),
    vx: 0,
    vy: 0
  }));

  simulationLinks = RAW_RELATIONSHIPS.map(r => ({
    ...r,
    sourceNode: simulationNodes.find(n => n.id === r.source),
    targetNode: simulationNodes.find(n => n.id === r.target)
  })).filter(l => l.sourceNode && l.targetNode);
}

function attachListeners() {
  window.addEventListener("resize", resizeCanvas);

  const btnHybrid = document.getElementById("style_hybrid");
  const btnRadial = document.getElementById("style_radial");
  const btnLinear = document.getElementById("style_linear");
  const btnCluster = document.getElementById("style_cluster");
  const themeSwitcher = document.getElementById("theme_switcher");
  const adminButton = document.getElementById("admin_button");

  if (btnHybrid) btnHybrid.onclick = () => (currentStyle = "hybrid");
  if (btnRadial) btnRadial.onclick = () => (currentStyle = "radial");
  if (btnLinear) btnLinear.onclick = () => (currentStyle = "linear");
  if (btnCluster) btnCluster.onclick = () => (currentStyle = "cluster");

  if (themeSwitcher) {
    themeSwitcher.onclick = () => {
      document.body.classList.toggle("light_theme");
    };
  }

  if (adminButton) {
    adminButton.onclick = () => {
      alert("Admin tools coming soon.");
    };
  }

  if (canvas) {
    canvas.addEventListener("click", handleCanvasClick);
  }
}

/* ============================================================
   PHYSICS
============================================================ */

function applyForces() {
  const preset = STYLE_PRESETS[currentStyle] || STYLE_PRESETS.hybrid;
  const cx = canvas.width / 2;
  const cy = canvas.height / 2;

  simulationNodes.forEach(n => {
    n.vx *= 0.9;
    n.vy *= 0.9;
  });

  simulationLinks.forEach(link => {
    const a = link.sourceNode;
    const b = link.targetNode;
    const dx = b.x - a.x;
    const dy = b.y - a.y;
    const dist = Math.sqrt(dx * dx + dy * dy) || 0.001;
    const desired = 140;
    const diff = dist - desired;
    const force = preset.linkStrength * diff;

    const fx = (dx / dist) * force;
    const fy = (dy / dist) * force;

    a.vx += fx;
    a.vy += fy;
    b.vx -= fx;
    b.vy -= fy;
  });

  for (let i = 0; i < simulationNodes.length; i++) {
    for (let j = i + 1; j < simulationNodes.length; j++) {
      const a = simulationNodes[i];
      const b = simulationNodes[j];
      const dx = b.x - a.x;
      const dy = b.y - a.y;
      const distSq = dx * dx + dy * dy || 0.001;
      const dist = Math.sqrt(distSq);
      const minDist = 40;

      const force = preset.repulsion / distSq;
      const fx = (dx / dist) * force;
      const fy = (dy / dist) * force;

      a.vx -= fx;
      a.vy -= fy;
      b.vx += fx;
      b.vy += fy;

      if (dist < minDist) {
        const overlap = (minDist - dist) / 2;
        const ox = (dx / dist) * overlap;
        const oy = (dy / dist) * overlap;
        a.x -= ox;
        a.y -= oy;
        b.x += ox;
        b.y += oy;
      }
    }
  }

  simulationNodes.forEach(n => {
    const dx = cx - n.x;
    const dy = cy - n.y;
    n.vx += dx * preset.centerForce * 0.001;
    n.vy += dy * preset.centerForce * 0.001;
  });

  simulationNodes.forEach(n => {
    n.x += n.vx;
    n.y += n.vy;
  });
}

/* ============================================================
   DRAWING
============================================================ */

function drawNode(node) {
  ctx.beginPath();
  ctx.arc(node.x, node.y, 14, 0, Math.PI * 2);
  ctx.fillStyle = "#ffd86f";
  ctx.fill();

  ctx.fillStyle = "#111418";
  ctx.font = "11px Inter, sans-serif";
  ctx.textAlign = "center";
  ctx.fillText(node.name, node.x, node.y - 20);
}

function drawLink(link) {
  ctx.beginPath();
  ctx.moveTo(link.sourceNode.x, link.sourceNode.y);
  ctx.lineTo(link.targetNode.x, link.targetNode.y);
  ctx.strokeStyle = "rgba(200,200,200,0.6)";
  ctx.lineWidth = 2;
  ctx.stroke();
}

function render() {
  if (!canvas || !ctx) return;
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  applyForces();
  simulationLinks.forEach(drawLink);
  simulationNodes.forEach(drawNode);
  requestAnimationFrame(render);
}

/* ============================================================
   INTERACTION
============================================================ */

function handleCanvasClick(event) {
  const rect = canvas.getBoundingClientRect();
  const x = event.clientX - rect.left;
  const y = event.clientY - rect.top;

  const clicked = simulationNodes.find(n => {
    const dx = n.x - x;
    const dy = n.y - y;
    return Math.sqrt(dx * dx + dy * dy) < 14;
  });

  if (!clicked) return;

  const nameEl = document.getElementById("node_name");
  const roleEl = document.getElementById("node_role");
  const relEl = document.getElementById("node_relationships");

  if (nameEl) nameEl.textContent = `Name: ${clicked.name}`;
  if (roleEl) roleEl.textContent = `Role: ${clicked.role}`;

  const rels = RAW_RELATIONSHIPS.filter(
    r => r.source === clicked.id || r.target === clicked.id
  );
  if (relEl) relEl.textContent = `Relationships: ${rels.length}`;
}

/* ============================================================
   MASTER BOOTSTRAP
============================================================ */

window.addEventListener("load", () => {
  canvas = document.getElementById("network_canvas");
  if (!canvas) {
    console.error("Canvas element #network_canvas not found.");
    return;
  }
  ctx = canvas.getContext("2d");
  resizeCanvas();
  initializeSimulation();
  attachListeners();
  render();
});