note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make
feature -- command
	undo
		local
			errors : ERRORS
    	do
    		create errors.make
			-- perform some update on the model state
			model.default_update
			-- either undo or "there is nothing left to undo"
			model.state.set_undo_redo(FALSE)

			if model.history.is_empty or model.history.is_back_invalid then
				model.state.set_undo_redo(FALSE)
				model.state.set_invalid_undo(TRUE)
			elseif model.history.on_item then
				model.state.set_undo_redo(TRUE)
				model.state.set_invalid_undo(FALSE)
				model.history.item.undo
				model.state.state_msg_update (model.history.item.item)
				model.state.set_state_i (model.history.item.last_valid_id)
				model.history.back
				if model.history.is_back_invalid then
					model.state.set_last_valid_i (model.state.get_first_i)
				else
					model.state.set_last_valid_i (model.history.item.state_id)
				end
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
