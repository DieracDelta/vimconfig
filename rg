Connect to Tailscale, logging in if needed

USAGE
  tailscale up [flags]

"tailscale up" connects this machine to your Tailscale network,
triggering authentication if necessary.

With no flags, "tailscale up" brings the network online without
changing any settings. (That is, it's the opposite of "tailscale
down").

If flags are specified, the flags must be the complete set of desired
settings. An error is returned if any setting would be changed as a
result of an unspecified flag's default value, unless the --reset flag
is also used. (The flags --auth-key, --force-reauth, and --qr are not
considered settings that need to be re-specified when modifying
settings.)

FLAGS
  --accept-dns, --accept-dns=false
    	accept DNS configuration from the admin panel (default true)
  --accept-risk string
    	accept risk and skip confirmation for risk types: lose-ssh,mac-app-connector,all
  --accept-routes, --accept-routes=false
    	accept routes advertised by other Tailscale nodes (default false)
  --advertise-connector, --advertise-connector=false
    	advertise this node as an app connector (default false)
  --advertise-exit-node, --advertise-exit-node=false
    	offer to be an exit node for internet traffic for the tailnet (default false)
  --advertise-routes string
    	routes to advertise to other nodes (comma-separated, e.g. "10.0.0.0/8,192.168.0.0/24") or empty string to not advertise routes
  --advertise-tags string
    	comma-separated ACL tags to request; each must start with "tag:" (e.g. "tag:eng,tag:montreal,tag:ssh")
  --auth-key string
    	node authorization key; if it begins with "file:", then it's a path to a file containing the authkey
  --exit-node string
    	Tailscale exit node (IP or base name) for internet traffic, or empty string to not use an exit node
  --exit-node-allow-lan-access, --exit-node-allow-lan-access=false
    	Allow direct access to the local network when routing traffic via an exit node (default false)
  --force-reauth, --force-reauth=false
    	force reauthentication (WARNING: this will bring down the Tailscale connection and thus should not be done remotely over SSH or RDP) (default false)
  --hostname string
    	hostname to use instead of the one provided by the OS
  --json, --json=false
    	output in JSON format (WARNING: format subject to change) (default false)
  --login-server string
    	base URL of control server (default https://controlplane.tailscale.com)
  --netfilter-mode string
    	netfilter mode (one of on, nodivert, off) (default on)
  --operator string
    	Unix username to allow to operate on tailscaled without sudo
  --qr, --qr=false
    	show QR code for login URLs (default false)
  --reset, --reset=false
    	reset unspecified settings to their default values (default false)
  --shields-up, --shields-up=false
    	don't allow incoming connections (default false)
  --snat-subnet-routes, --snat-subnet-routes=false
    	source NAT traffic to local routes advertised with --advertise-routes (default true)
  --ssh, --ssh=false
    	run an SSH server, permitting access per tailnet admin's declared policy (default false)
  --stateful-filtering, --stateful-filtering=false
    	apply stateful filtering to forwarded packets (subnet routers, exit nodes, etc.) (default false)
  --timeout duration
    	maximum amount of time to wait for tailscaled to enter a Running state; default (0s) blocks forever (default 0s)
