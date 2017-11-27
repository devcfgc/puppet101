# puppet101
This is a repository for testing purpose particularly for experiment with new puppet versions

### Install puppetserver V5
  - `vagrant up`
  - login in the vagrant box as `sudo su`
  - `rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm`
  - `yum install -y puppetserver vim git`

### Configure puppetserver
  - `vim /etc/sysconfig/puppetserver`
    ```
    #replace the minimum and maximum amount of memory that Java will use
    JAVA_ARGS="-Xms2g -Xmx2g -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"
    # to use 512m
    JAVA_ARGS="-Xms512m -Xmx512m -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"
    ```
  - `systemctl start puppetserver`
  - `systemctl enable puppetserver`

### Configure puppet agent
  - `vim /etc/puppetlabs/puppet/puppet.conf`
    ```
    [master]
    vardir = /opt/puppetlabs/server/data/puppetserver
    logdir = /var/log/puppetlabs/puppetserver
    rundir = /var/run/puppetlabs/puppetserver
    pidfile = /var/run/puppetlabs/puppetserver/puppetserver.pid
    codedir = /etc/puppetlabs/code

    [agent]
    server = master.puppet.vm
    ```
  - `vim .bash_profile`
    ```
    PATH=$PATH:/opt/puppetlabs/puppet/bin:$HOME/.local/bin:$HOME/bin
    ```
  - `source .bash_profile`
  - `gem install r10k`
  - test puppet agent executing `puppet agent -t` or `puppet agent -t --environment=production`
  - `mkdir /etc/puppetlabs/r10k`
  - `vim /etc/puppetlabs/r10k/r10k.yaml` (you need to copy and paste the content from the file r10k.yaml from this repository)
  - `r10k deploy environment -p` deploy environment to the repository

### Using docker
  - `docker exec -it web.puppet.vm bash`
  - `docker exec -it db.puppet.vm bash`
  - `puppet cert list`
  - `puppet cert sign -a`
