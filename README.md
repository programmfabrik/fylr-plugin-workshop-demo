# fylr-plugin-workshop-demo

Lab material for the fylr plugin programming workshop. The plugin is called
`workshop-demo` and shows one small example per extension point covered in
the workshop handbook. It is written for fylr 6.34.

| Part | File | What it does |
|------|------|--------------|
| Extension | `server/extension/hello.js` | `POST /api/v1/plugin/extension/workshop-demo/hello` answers with a greeting and the number of ids sent |
| `db_pre_save` callback | `server/callback/check_name.js` | On every save of a `personen` object: trims `name`, rejects the save if `name` contains the word from the base config |
| Base config | `manifest.yml` (`base_config`) | One setting, `forbidden_word` |
| Toolbar tool | `webfrontend/WorkshopDemoCollectionPlugin.coffee` | A tool for the selected objects that calls the extension |
| Detail sidebar | `webfrontend/WorkshopDemoSidebar.coffee` | A button in the detail sidebar with a small info pane |
| Custom data type | `webfrontend/WorkshopDemoNote.coffee`, `manifest.yml` (`custom_types`) | `custom:base.workshop-demo.note`, a text plus a URL |
| Localization | `l10n/workshop-demo.csv` | Keys for all of the above |

The callback expects an objecttype `personen` with a text field `name`. Change
the filter in `manifest.yml` and the field name in `check_name.js` to match
your own datamodel.

## Building

Built by [fylr-build-plugin](https://github.com/programmfabrik/fylr-build-plugin).
The Makefile is a thin shim, run `make` for the target list. You need Go,
Node.js and CoffeeScript 1.x (`npm install -g coffeescript@1.12.7`).

    make build    # build/workshop-demo/, loadable by fylr via plugin.paths
    make zip      # the release zip in build/

For development, point the fylr server at the build folder in `fylr.yml`:

```yaml
plugin:
    paths+:
        - ../fylr-plugin-workshop-demo/build
```

A plugin loaded from disk starts disabled. Enable it in the plugin manager and
set its update policy to "always (development)" so that a rebuild is picked up.

## Releasing

A manager publishes a release on the GitHub release page (tag `vX.Y.Z`); the
workflow builds the plugin zip and attaches it to the release.
