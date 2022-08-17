-- Forcibly reload a module
return function(module)
  for pack, _ in pairs(package.loaded) do
    if pack == module then
      package.loaded[pack] = nil
    end
  end

  return require(module)
end
