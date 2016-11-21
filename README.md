# PhysEx
Programming Language to ease creating of physics engines and fast prototyping.


Compile into executable:
(./physex.native <  examples/helloworld.x ) > test.ll
lli test.ll




------------------ Importing the Image in Virtualbox ---------------------------
1. Download the Ubuntu image from    http://www.cs.columbia.edu/~sedwards/classes/2016/4115-fall/PLT4115.7z
   From the command-line, you may be able to do this with    $ wget http://www.cs.columbia.edu/~sedwards/classes/2016/4115-fall/PLT4115.7z 2. Uncompress the image and move the PLT4115 directory from downloads
   to a permament location (ex. to your home directory).    Some options for uncompressing:    Linux:
       $ sudo apt-get install p7zip        $ 7za x ~/Downloads/PLT4115.7z
       Note: p7zip can also be brew installed on OSX
   OSX:        use the Unarchiver app
   Windows:        use winzip
3. In Virtualbox, select Machine -> Add from the top bar
4. Browse to and select the "PLT4115.vbox" file in the PLT4115 directory    created by uncompressing the .7z file
5. Virtualbox should load your VM; it is now ready to boot
----------------- VM User Account -----------------
The VM comes with the following account.
User:   plt4115 Passwd: plt4115
This account has "sudo" enabled
----------------------------------- Connecting the VM to the Internet -----------------------------------
If your VM is powered on,
1. From the running VM window, select    Devices -> Network -> Connect Network Adapter
If your VM is powered off,
1. In virtualbox, select the VM and edit its settings 2. In settings, select the Network tab 3. Check the box that says "Cable Connected", and hit ok
------------------------- Adding a GUI to your VM -------------------------

Full desktop GUI (takes a really long time to install):
1. Log into the VM 2. Enter the following commands
   $ sudo apt-get update    $ sudo apt-get install ubuntu-desktop
Minimal Lightweight Gnome Desktop:
1. Log into the VM 2. Enter the following commands:
   $ sudo apt-get update    $ sudo apt-get install xorg gnome-core gnome-system-tools gnome-app-install
