--[[
Copyright: © 2024 Pierre-Amiel Giraud
License:   GNU GPL v3 – see LICENSE file for details
From: https://github.com/pagiraud/speakernotes
--]]

--parameters (p) that can be declared in the YAML header
local p = {
    ["displayNotes"] = false,
    ["notesTitle"] = "Notes",
    ["borderColor"] = "red", -- Only for latex and html outputs
    ["backgroundColor"] = "white", -- Only for latex and html outputs
    ["customStyle"] = "", -- Only for latex and html outputs
    }
  
  -- For PDF output
  local neededPackages = [[
  \makeatletter
  \@ifpackageloaded{tikz}{}{\usepackage{mdframed}}
  \makeatother
  ]]
  
  
  --[[Make the Notes style in the header / preamble. For now, only for latex and html outputs
  If no customStyle is declared in the YAML header, build with borderColor, notesTitle and borderColor parameters (see p variable).
  If there is a customStyle declared, use it.
  --]]
  local function makeNotesEnv(title, border, background, customstyle)
    local notesEnv = ""
    if FORMAT == "latex" then
      if customstyle:len() == 0 then
        notesEnv = [[\newmdenv[linecolor=]] .. border .. [[,backgroundcolor=]] .. background .. [[,frametitle=]] .. title .. [[]{notes}]]
      else
        notesEnv = [[\newmdenv[]] .. customstyle .. [[]{notes}]]
      end
      return pandoc.RawBlock('latex', notesEnv)
    elseif FORMAT == "html" then
      if customstyle:len() == 0 then
        local htmlNotesTitle = ""
        if title:len() ~= 0 then -- If a title is provided in the YAML header (default ok), display it using the ::before pseudo-element.
          htmlNotesTitle = "div.notes::before{content: \"" .. title .. "\"; font-weight: bold;}"
        end
        notesEnv = [[<style>
  div.notes{border: solid; padding: 0.5em; background-color: ]] .. background .. [[; border-color: ]] .. border .. [[;}
  ]]
  .. htmlNotesTitle .. [[
  </style]]
      else
        notesEnv = customstyle
      end
      return pandoc.RawBlock('html', notesEnv)
    end
    return
  end
  
  local function parameters(meta)
    --Retrieve parameters from the YAML header
    if meta.speakernotes ~= nil then
      for k, v in pairs(meta.speakernotes) do p[k] = pandoc.utils.stringify(v) end
    end
    if p.displayNotes == "true" then
      local notesEnv = ""
      --Retrieve header-includes content and append our content (without dropping the includes wanted by the user)
      local includes = meta['header-includes']
      --Default to a list
      includes = includes or pandoc.List({ })
      -- If not a List make it one!
      if 'List' ~= pandoc.utils.type(includes) then
        includes = pandoc.List({ includes })
      end
      includes:insert(pandoc.RawBlock('latex', neededPackages)) --Add latex packages
      notesEnv = makeNotesEnv(p.notesTitle, p.borderColor, p.backgroundColor, p.customStyle)
      includes:insert(notesEnv)
      -- Make sure Pandoc gets our changes
      meta['header-includes'] = includes
    end
    return meta
  end
  
  local function notesDiv(el)
    if el.classes[1] == "notes" then --Check if first class of the Div is notes. Maybe it should be if el.classes:includes 'notes' then, so that if notes is not the first class, it is still catched.
      if p.displayNotes == "true" then
        if FORMAT == "latex" then
          -- For latex, we need to wrap the Div in a notes environment
          -- insert element in front
          table.insert(
          el.content, 1,
          pandoc.RawBlock("latex", "\\begin{notes}"))
          -- insert element at the back
          table.insert(
          el.content,
          pandoc.RawBlock("latex", "\\end{notes}"))
        elseif FORMAT == "odt" or FORMAT == "docx" then -- These outputs don’t take classes into account, only custom-style attribute. So set them to Notes (Cap intended for consistency with other style names of the reference doc).
          el.attributes['custom-style'] = "Notes"
          if p.notesTitle:len() ~= 0 then -- If there is a notesTitle defined in the YAML header (default ok), add it before the notes div.
            local notesTitlePara = pandoc.Div(pandoc.Para(p.notesTitle))
            notesTitlePara.attributes['custom-style'] = "Notes Title"
            table.insert(el.content, 1, notesTitlePara)
          end
        --Nothing to do here for html outputs, since notes is already added as a class by Pandoc. Could be a place to add the NotesTitle instead of using ::before in the header.
        end
      else
        el = {} -- if p.displaNotes is not set to "true" (string) in the YAML header, drop the div.
      end
    end
    return el
  end
  
  return {{Meta = parameters}, {Div = notesDiv}}
  