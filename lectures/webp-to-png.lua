-- webp-to-png.lua
--
-- Pandoc Lua filter used by Quarto when rendering to PDF.
--
-- LaTeX does not support .webp images, so this filter converts any
-- referenced .webp image into a temporary .png using ImageMagick.
-- The document is then rewritten to reference the generated .png file.
--
-- The corresponding cleanup script (webp-cleanup-png.sh) removes the
-- generated .png files after rendering so the repository only keeps
-- the original .webp assets.
--
-- Requirements:
--   - ImageMagick (`magick` command) must be installed and available in PATH.
--   - Enabled in _quarto.yml via:
--         filters:
--           - webp-to-png.lua
--
function Image(el)
  -- Check if the image source ends with ".webp"
  if string.match(el.src, "%.webp$") then

    -- Replace the extension with ".png"
    local new = el.src:gsub("%.webp$", ".png")

    -- Convert the image using ImageMagick
    os.execute("magick " .. el.src .. " " .. new)

    -- Update the document to reference the converted PNG
    el.src = new
  end

  return el
end