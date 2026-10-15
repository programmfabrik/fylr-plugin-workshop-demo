# Adds a tool for the selected objects (toolbar and context menu)
class WorkshopDemoCollectionPlugin extends CollectionPlugin

	getCurrentTools: (collection) ->
		# getCurrentTools is called for every kind of collection, also for the
		# collections in the collection tree (right click). Only a selection
		# implements getObjects(), the base class asserts.
		if collection not instanceof CollectionSelection
			return []

		objects = collection.getObjects()
		if not objects?.length
			return []   # nothing selected: no tool

		[
			new ToolboxTool
				group: collection.getToolGroup()
				name: "workshop-demo.hello"   # label: "tool.workshop-demo.hello|text"
				sort: "I:1"
				favorite: true
				run: =>
					ids = (o.getGlobalObjectId() for o in objects)
					ez5.server
						api: "/plugin/extension/workshop-demo/hello"
						type: "POST"
						json_data: ids: ids
					.done (response) =>
						CUI.alert(text: response.message)
		]

ez5.session_ready ->
	Collection.registerPlugin(new WorkshopDemoCollectionPlugin())
