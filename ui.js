/* -----------------------------------------------------------
   ETERNAL CURRENTS — UI CONTROLLER
   Node selection · Relationship panel · Layout switching
----------------------------------------------------------- */

window.EC_UI = {};

/* -----------------------------------------------------------
   DOM ELEMENTS
----------------------------------------------------------- */
const nodeNameEl = document.getElementById("nodeName");
const nodeRoleEl = document.getElementById("nodeRole");
const nodeTagsEl = document.getElementById("nodeTags");
const relationshipListEl = document.getElementById("relationshipList");

/* -----------------------------------------------------------
   SET SELECTED NODE
----------------------------------------------------------- */
window.EC_UI.setSelectedNode = function (node) {
  if (!node) {
    nodeNameEl.textContent = "—";
    nodeRoleEl.textContent = "Click a node to inspect.";
    nodeTagsEl.innerHTML = "";
    relationshipListEl.textContent = "No node selected.";
    return;
  }

  // Name + role
  nodeNameEl.textContent = node.label;
  nodeRoleEl.textContent = node.role;

  // Tags
  nodeTagsEl.innerHTML = "";
  const tags = [];

  if (node.type === "parent") tags.push("Parent");
  if (node.type === "self") tags.push("Self / Partner / Child");
  if (node.type === "other") tags.push("Extended / Other");

  tags.forEach((t) => {
    const el = document.createElement("div");
    el.className = "tag highlight";
    el.textContent = t;
    nodeTagsEl.appendChild(el);
  });

  // Relationships
  const connected = EC.links.filter(
    (l) => l.source.id === node.id || l.target.id === node.id
  );

  if (!connected.length) {
    relationshipListEl.textContent = "No direct relationships recorded.";
    return;
  }

  relationshipListEl.innerHTML = "";

  connected.forEach((l) => {
    const other = l.source.id === node.id ? l.target.id : l.source.id;

    const row = document.createElement("div");
    row.style.marginBottom = "6px";

    const strength =
      l.kind === "core"
        ? "Primary / Core"
        : l.kind === "parent"
        ? "Parent Link"
        : "Extended Link";

    row.innerHTML = `
      <div style="color:#f7f7f7;">${node.label} ↔ ${other}</div>
      <div style="color:#6f7490; font-size:11px;">${strength}</div>
    `;

    relationshipListEl.appendChild(row);
  });
};

/* -----------------------------------------------------------
   LAYOUT SWITCHER
----------------------------------------------------------- */
document.getElementById("layoutSwitcher").addEventListener("click", (e) => {
  const btn = e.target.closest("button");
  if (!btn) return;

  const layout = btn.dataset.layout;

  // Update button states
  document
    .querySelectorAll("#layoutSwitcher button")
    .forEach((b) => b.classList.remove("active"));
  btn.classList.add("active");

  // Apply layout
  EC.applyLayout(layout);
});

/* -----------------------------------------------------------
   INITIALIZE DEFAULT NODE
----------------------------------------------------------- */
const meNode = EC.nodes.find((n) => n.id === "ME") || EC.nodes[0];
window.EC_UI.setSelectedNode(meNode);