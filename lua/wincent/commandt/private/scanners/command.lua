-- SPDX-FileCopyrightText: Copyright 2022-present Greg Hurrell and contributors.
-- SPDX-License-Identifier: BSD-2-Clause

local command = {}

command.scanner = function(user_command, drop, max_files)
  local lib = require('wincent.commandt.private.lib')
  local scanner = lib.scanner_new_command(user_command, drop, max_files)
  return scanner
end

return command
