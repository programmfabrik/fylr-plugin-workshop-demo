// db_pre_save: trim names, reject a configured forbidden word
let input = "";
process.stdin.on("data", (d) => (input += d));
process.stdin.on("end", () => {
  const { info, objects } = JSON.parse(input);
  const word = info.config?.plugin?.["workshop-demo"]?.config
    ?.settings?.forbidden_word?.trim();

  const changed = [];
  for (const obj of objects) {
    const data = obj[obj._objecttype];
    const name = data.name ?? "";

    if (word && name.toLowerCase().includes(word.toLowerCase())) {
      console.log(JSON.stringify({
        error: {
          code: "workshop-demo.error.forbidden_word",
          parameters: { word },
          realm: "api",
          statuscode: 400,
        },
      }));
      return; // exit code 0 is fine: the error sits under "error"
    }

    if (name !== name.trim()) {
      data.name = name.trim();
      changed.push(obj); // return only what we changed
    }
  }
  console.error(`check_name: ${changed.length} of ${objects.length} changed`);
  console.log(JSON.stringify({ objects: changed }));
});
