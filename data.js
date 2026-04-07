/* -----------------------------------------------------------
   ETERNAL CURRENTS — DATA MODEL
   Full dataset for the four‑mode visualization engine
----------------------------------------------------------- */

window.EC_DATA = {
  nodes: [
    { id: "ME", label: "ME", role: "Self", type: "self" },
    { id: "My Wife", label: "My Wife", role: "Partner", type: "self" },
    { id: "My Son", label: "My Son", role: "Child", type: "self" },

    { id: "Biological Mom", label: "Biological Mom", role: "Parent", type: "parent" },
    { id: "Brandon's Dad", label: "Brandon's Dad", role: "Parent", type: "parent" },

    { id: "SIS", label: "SIS", role: "Sibling", type: "other" },
    { id: "BRO", label: "BRO", role: "Sibling", type: "other" },
    { id: "SIB", label: "SIB", role: "Sibling", type: "other" },

    { id: "MVP", label: "MVP", role: "Extended / Other", type: "other" }
  ],

  links: [
    // Biological Mom → children
    { source: "Biological Mom", target: "ME", strength: 1.0, kind: "parent" },
    { source: "Biological Mom", target: "SIS", strength: 0.9, kind: "parent" },
    { source: "Biological Mom", target: "BRO", strength: 0.9, kind: "parent" },
    { source: "Biological Mom", target: "SIB", strength: 0.9, kind: "parent" },

    // Brandon's Dad → children
    { source: "Brandon's Dad", target: "ME", strength: 0.9, kind: "parent" },
    { source: "Brandon's Dad", target: "SIB", strength: 0.9, kind: "parent" },
    { source: "Brandon's Dad", target: "MVP", strength: 0.7, kind: "other" },

    // Nuclear family
    { source: "ME", target: "My Wife", strength: 1.0, kind: "core" },
    { source: "ME", target: "My Son", strength: 1.0, kind: "core" },
    { source: "My Wife", target: "My Son", strength: 1.0, kind: "core" }
  ]
};