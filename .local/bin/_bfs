#!/usr/bin/env node

const fs = require("node:fs");

const bfs = (node) => {
  if (node == null || typeof node !== "object") return;

  const queue = [];
  queue.push({ name: "", n: node });

  while (queue.length > 0) {
    const o = queue.shift();
    const { name, n } = o;

    if (n == null) continue;
    if (typeof n !== "object") {
      console.log(`${name}\t${typeof n}\t${JSON.stringify(n)}`);
    }

    if (typeof n === "object") {
      const keys = Object.keys(n);
      for (const k of keys) {
        queue.push({ name: `${name}.${k}`, n: n[k] });
      }
    }
  }
};

const main = () => {
  fs.readFile(process.argv[2], "utf8", (error, data) => {
    if (error) {
      console.log(error);
      return;
    }
    bfs(JSON.parse(data));
  });
};

main();
