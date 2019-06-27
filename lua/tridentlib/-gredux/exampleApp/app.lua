--[[tridentlib
  "name": "Gredux ExampleApp",
  "state": "Client"
--tridentlib]]

local app = tridentlib("GREDUX::CreateApp", "ExampleApp")
		app:tridentlib("GREDUX::setStore", "ExampleApp_Store")
		app:tridentlib("GREDUX::setApp", "ExampleApp_MainFrame")