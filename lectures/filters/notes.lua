function Div(el)
  if el.classes:includes("notes") then
    if quarto.doc.is_format("typst") then
      local typst_inner = pandoc.write(pandoc.Pandoc(el.content), "typst")
      local block = string.format(
        "#block(fill: luma(235), inset: (x: 0.5em, y: 0.4em), radius: 0.3em, width: 100%%, stroke: (left: 2pt + gray))[#text(size: 8pt)[%s]]",
        typst_inner
      )
      return pandoc.RawBlock("typst", block)
    end
    return {}
  end
end
