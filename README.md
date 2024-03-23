## clabs-host-kind

Dockerfiles and sample containerlab topology with two linux flavors (ubuntu, debian) containers started with systemd and ssh service.

Using containerlab or in general testing linux systemd services, I wanted to have my containers supporting systemd services so I could test them.

The build specs are in the [images](/images) folder and the containerlab sample topology in the [topo](/topo) one.

The clab lab folder is created in the root directory when using make.

---
inspired by [Michael Kashin](https://github.com/networkop/cx/tree/main/host) 
and [Akihiro Suda](https://github.com/AkihiroSuda/containerized-systemd.git) work.