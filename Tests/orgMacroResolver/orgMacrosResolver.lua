local utils = require 'pandoc.utils'
local stringify = utils.stringify

local orgMacros = {
  ['latex'] = true,
}

function macroResolverLatex(format)
  if format == 'latex' then
    return pandoc.RawInline('latex', "\\LaTeX\\")
  elseif format:match 'context' then
    return pandoc.RawInline('tex', "\\TeX\\")
  else
    return pandoc.Str "LaTeX"
  end
end

function Inlines (inlines)
  for i = 1, #inlines do
    
	  local currentEl = inlines[i] -- variable holding current element
	
	  -- variables holding org macro expansions (replacements)
	
	  local latexMacro = macroResolverLatex(FORMAT)
	
	  if currentEl.t == 'Str' then
	    for macro, _ in pairs(orgMacros) do
	      if string.match(currentEl.text, '{{{ .. macro .. }}}') then
		      inlines[i] = latexMacro
		    end
	    end
	  end
	
  end
  
  return inlines
end

return {
  {Inlines = Inlines},
}
