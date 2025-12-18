{ pkgs, ... }:

{
  # --- 1. Kernel Selection ---
  # linux_zen is a "tuned" version of the standard Linux kernel.
  # It uses a different "Sheduler" (how the CPU decides which app gets power).
  # It prioritizes apps you are actually interacting with (like games or your browser)
  # over background tasks, making the desktop feel much "snappier."
  boot.kernelPackages = pkgs.linuxPackages;

  # Firmware update service. Essential for updating SSDs and motherboards.
  services.fwupd.enable = true;

  # --- 2. Low-Level Security (CPU Mitigations) ---
  security = {
    # FORCE PAGE TABLE ISOLATION (PTI):
    # This is a defense against the 'Meltdown' bug. It prevents a regular 
    # program from even 'seeing' the memory addresses used by the Kernel.
    # Without this, a malicious script could potentially steal passwords from RAM.
    forcePageTableIsolation = true;
    
    # L1 DATA CACHE FLUSHING: 
    # Protects against 'L1 Terminal Fault'. It forces the CPU to 'wipe' its 
    # fastest memory (L1 Cache) when switching contexts. This prevents a
    # virtual machine or a malicious process from reading data left behind 
    # by the previous process.
    virtualisation.flushL1DataCache = "cond";
    
    # UNPRIVILEGED USER NAMESPACES:
    # Modern apps (like Discord, Chrome, and Flatpaks) create 'sandboxes' 
    # to protect your system. This setting allows them to create those 
    # mini-containers without needing root (sudo) access.
    unprivilegedUsernsClone = true;
  };

  # --- 3. Kernel Boot Parameters ---
  # These are instructions passed to the kernel at the very first second of boot.
  boot.kernelParams = [ 
    # --- Aesthetics & Silence ---
    "quiet"                      # Don't print successful start messages.
    "splash"                     # Tell the kernel to support a graphical splash (Plymouth).
    "loglevel=3"                 # Hide 'Warnings' and 'Info', only show 'Errors'.
    "rd.udev.log_priority=3"     # Tell the device manager (udev) to keep its logs quiet too.
    "vt.global_cursor_default=0" # Remove the blinking '_' during boot for a cleaner look.
    "rd.systemd.show_status=false" # Hide systemd status messages
    # --- Graphics & Display ---
    # fbcon=nodefer: Normally, the kernel waits a bit to initialize the console 
    # display. This forces it to start immediately, preventing the 'black screen' 
    # gap between the bootloader and your splash screen.
    "fbcon=nodefer"           

    # --- Linux Security Modules (LSM) ---
    # This defines the 'security layers' active in your kernel.
    # AppArmor: Restricts what files/network ports apps can access.
    # Yama: Prevents one program from 'attaching' to another (prevents spy tools).
    # Landlock: A newer tech that allows apps to sandbox themselves.
    #"lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
    
    # --- Hardware Compatibility ---
    # usbcore.autosuspend=-1: Disables the 'sleep' feature for USB ports.
    # This is a lifesaver for mechanical keyboards and high-polling mice that 
    # might otherwise feel 'laggy' when you first touch them after a pause.
    "usbcore.autosuspend=-1"

    # acpi_rev_override=5: Tells the motherboard to behave as if it's talking 
    # to a specific version of Windows. This often fixes broken touchpads, 
    # brightness keys, or sleep/wake issues on modern hardware.
    #"acpi_rev_override=5"
  ];
}