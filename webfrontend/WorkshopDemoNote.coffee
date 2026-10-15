# Custom data type "custom:base.workshop-demo.note": a text plus a URL
class WorkshopDemoNote extends CustomDataType

	getCustomDataTypeName: ->
		"custom:base.workshop-demo.note"

	# mandatory: tags shown for the field in the datamodel overview
	getCustomDataOptionsInDatamodelInfo: (custom_settings) ->
		[]

	supportsStandard: ->
		true

	isEmpty: (data, top_level_data, opts) ->
		cdata = data[@name()]
		CUI.util.isEmpty(cdata?.text?.trim()) and CUI.util.isEmpty(cdata?.url?.trim())

	renderEditorInput: (data, top_level_data, opts) ->
		data[@name()] ?= {}
		cdata = data[@name()]
		form = new CUI.Form
			data: cdata
			fields: [
				form: label: "Text"
				type: CUI.Input
				name: "text"
			,
				form: label: "URL"
				type: CUI.Input
				name: "url"
			]
			onDataChanged: =>
				CUI.Events.trigger(node: form, type: "editor-changed")
		form.start()

	renderDetailOutput: (data, top_level_data, opts) ->
		new CUI.Label(text: data[@name()]?.text or "")

	getSaveData: (data, save_data, opts) ->
		# an empty field is saved as null, otherwise fylr stores
		# {"_fulltext":{},"_standard":{}} as a value
		if @isEmpty(data)
			save_data[@name()] = null
			return

		cdata = data[@name()]
		save_data[@name()] =
			text: cdata.text
			url: cdata.url
			_fulltext:
				text: cdata.text
				string: cdata.url
			_standard:
				text: cdata.text
		return

# registered at top level: field types must be known before the datamodel is read
CustomDataType.register(WorkshopDemoNote)
