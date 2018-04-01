# flexterra
1. Install Terraform
Download terraform depending on your system. Installation is very simple. Download the terraform zip archive and unzip it in a suitable location. Once we have unzipped the terraform, update PATH environment variable pointing to terraform. Since the folder /usr/local/bin is already set to PATH environment variable, we don’t need to set it again. If you are using any other location, then specify it in the PATH environment variable either in .bash_profile or in /etc/profile.
$ wget https://releases.hashicorp.com/terraform/0.10.7/terraform_0.10.7_linux_386.zip
$ unzip terraform_0.10.7_linux_386.zip
$ mv terraform /usr/local/bin/
$ export PATH=$PATH:/usr/local/bin/
Check the installation: 
$ terraform -v
--If you want the latest version just change the 0.10.7 to 0.10.9 corresponding version number

