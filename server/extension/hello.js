// POST /api/v1/plugin/extension/workshop-demo/hello
const info = JSON.parse(process.argv[2]); // %info.json%: inline JSON, not a path

let body = "";
process.stdin.on("data", (d) => (body += d));
process.stdin.on("end", () => {
  const request = body ? JSON.parse(body) : {};
  console.log(JSON.stringify({
    message: `Hello ${info.api_user?.user?._generated_displayname}, ` +
             `you sent ${request.ids?.length ?? 0} id(s).`,
    method: info.request?.method,
  }));
});
