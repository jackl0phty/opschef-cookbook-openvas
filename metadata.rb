maintainer       "Gerald L. Hevener Jr., M.S."
maintainer_email "jackl0phty@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures openvas"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.52"
%w{ apt perl }.each do |cb|
  depends cb
end
