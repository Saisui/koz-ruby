def import file, into: nil
  code = File.read file
  m = into || Module.new
  unless into
    code = "module_function\n\n" + code
  end
  m.module_eval code, file
  m
end
