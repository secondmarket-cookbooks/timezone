name             "timezone"
maintainer       "James Harton"
maintainer_email "james@sociable.co.nz"
license          "Apache 2.0"
description      "Configure the system timezone."
version          "0.0.2"

%w{ ubuntu debian rhel centos scientific amazon fedora }.each do |os|
  supports os
end
