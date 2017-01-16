# jacobclark.xyz infrastructure 

### Description

A quick and dirty Digital Ocean image provisioner for [jacobclark.xyz](jacobclark.xyz) using Packer with simple shell scripts.

```
export DIGITALOCEAN_API_TOKEN = sometoken
./build
```

### Image details

ubuntu-16-04-x64, lon1, 512mb.

* 4GB swap file 
* Docker for application runtime
* Caddy for HTTP
* Systemd for process management
* Prometheus for metrics and monitoring
* Grafana for prometheus dashboards
* cAdvisor for container stats

### Running applications 

* jacobclark.xyz
* blog.jacobclark.xyz
* corscontainer.jacobclark.xyz
* ngaas.api.jacobclark.xyz
* devnews.today
* api.devnews.today
