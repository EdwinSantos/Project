note
	description: "Summary description for {REMOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_CONTAINER
inherit
	OPERATION
		redefine out end

create
	make

feature {NONE}
	make (cid_given: STRING; msg : STRING; st_id : INTEGER)
	do
		cid := cid_given
		error_string := ""
		item := msg
		state_id := st_id
		fillernum := -1
		create filler2.make_from_int (-1)
		if attached state.containers.at(cid_given) as cnat then
			create cn.make(cnat.cid, [cnat.mat, cnat.radioac], cnat.pid)
		else
			create cn.make ("-1", [fillernum.to_integer_64, filler2], "-1")
		end
		create error.make
	end

feature
	cid: STRING
	error : ERRORS
	cn : MATERIAL_CONTAINER


	-- "filler" objects with illegal values if the cid/pids given don't exist
	fillernum: INTEGER
	filler2 : VALUE

	is_invalid : BOOLEAN
		do
			Result := does_container_exist
		end

	does_container_exist : BOOLEAN
		do
			Result := FALSE
		end

	error_check
		do
			if does_container_exist then
				error_string := error.E15
			else
				error_string := error.OK
			end

		end

	execute
		do
			state.state_msg_update(error.OK)
			state.remove_container(cid)
		end

	undo
		do

		end

	redo
		do

		end

feature
	out : STRING
		do
			Result := item
		end
end
