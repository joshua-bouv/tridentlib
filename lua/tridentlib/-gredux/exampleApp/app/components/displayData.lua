--[[tridentlib
  "name": "COMPONENT || Display DATA.",
  "state": "Client"
--tridentlib]]

tridentlib("GREDUX::CreateComponent", "ExampleApp", "displayData", function(self)
	tridentlib("GREDUX::bindActions", self, {
		"getData"
	})

	tridentlib("GREDUX::bindState", self, {
		"data"
	})

	return {
		store = {
			localdata = "test"
		},

		beforeMount = {
			self.props.getData()
		},

		panel = function(self)
			local test = self.store.localdata

			print(test)

			print(self.props.

		end
	}
end)