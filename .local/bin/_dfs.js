#!/usr/bin/env node

const fs = require("node:fs");

const dfs = (node) => {
  if (node == null || typeof node !== "object") return;

  const stack = [];
  stack.push({ name: "", n: node });

  while (stack.length > 0) {
    const o = stack.pop();
    const { name, n } = o;

    if (n == null) continue;
    if (typeof n !== "object") {
      console.log(`${name}\t${typeof n}\t${JSON.stringify(n)}`);
    }

    if (typeof n === "object") {
      const keys = Object.keys(n);
      for (const k of keys) {
        stack.push({ name: `${name}.${k}`, n: n[k] });
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
    dfs(JSON.parse(data));
  });
};

main();
