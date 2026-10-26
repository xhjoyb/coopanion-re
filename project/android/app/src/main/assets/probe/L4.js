const fs = require("fs");
const http = require("http");
http.createServer((req,res)=>{res.end("hi");}).listen(19999, ()=>{
  console.log("L4-http-listen-OK");
  const s = fs.readFileSync("/etc/passwd","utf8");
  console.log("L4-fs-OK len=" + s.length);
  process.exit(0);
});
