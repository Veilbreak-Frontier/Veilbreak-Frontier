/datum/asset/changelog_item/New(date)
	. = ..()
	item_filename = SANITIZE_FILENAME("[date].yml")
	SSassets.transport.register_asset("venus_[item_filename]", file("html/changelogs/venus_archive/" + item_filename)) // VENUS EDIT ADDITION: Changelog 4

/datum/asset/changelog_item/send(client)
	. = ..()
	if(!.)
		return
	. = SSassets.transport.send_assets(client, "venus_[item_filename]")

/datum/asset/changelog_item/get_url_mappings()
	. = ..()
	LAZYADD(., list("venus_[item_filename]" = SSassets.transport.get_asset_url("venus_[item_filename]")))

/datum/asset/changelog_item/unregister()
	. = ..()
	if(!item_filename)
		return
	SSassets.transport.unregister_asset("venus_[item_filename]")
