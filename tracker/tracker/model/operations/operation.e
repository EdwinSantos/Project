note
	description: "Summary description for {OPERATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OPERATION
feature
	state: STATE
		local
			ma: ETF_MODEL_ACCESS
		once
			Result := ma.m.state
		end

	tictac: ETF_MODEL
		local
			ma: ETF_MODEL_ACCESS
		once
			Result := ma.m
		end

	item: STRING
	error_string: STRING

	get_error : STRING
		do
			Result := error_string
		end

	error_check
		deferred
		end

	execute
		deferred
		end

	undo
		deferred
		end

	redo
		deferred
		end

end
