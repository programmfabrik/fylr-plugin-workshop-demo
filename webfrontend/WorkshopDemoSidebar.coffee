# Adds a button to the detail view's sidebar that shows a small info pane
class WorkshopDemoSidebar extends DetailSidebarPlugin

	prefName: ->
		"workshop_demo_sidebar"

	getButtonLocaKey: ->
		"workshop-demo.sidebar.button"

	isAvailable: ->
		true

	showDetail: ->
		obj = @_detailSidebar.object.getData()
		word = ez5.session.getBaseConfig("plugin", "workshop-demo")
			.settings?.forbidden_word or "-"
		content = new CUI.VerticalList
			content: [
				new CUI.Label(text: $$("workshop-demo.sidebar.title"))
				new CUI.Label(text: "#{obj._objecttype} / #{obj._system_object_id}")
				new CUI.Label(text: $$("workshop-demo.sidebar.word", word: word))
			]
		@_detailSidebar.mainPane.replace(content, "top")

	hideDetail: ->
		@_detailSidebar.mainPane.empty("top")

ez5.session_ready ->
	DetailSidebar.plugins.registerPlugin(WorkshopDemoSidebar)
