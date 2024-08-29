# kolla-ansible-2023.1-jammy

Deploy an all-in-one environment of OpenStack 2023.1 version on ubuntu 22.04 server.

## prerequistes

Before using this script, you need to have `docker` and `python3` installed. The machine's configuration as below:

| HostName   | NICs                                       | Storage                                    |
| ---------- | ------------------------------------------ | ------------------------------------------ |
| controller | ens18: 5.39.122.88<br />ens19: no-assigned | need a volume group named `cinder-volumes` |

## How to use it

#### 1. Clear Old Environment

First, ensure that the old environment is cleared by running the `clear.sh` script.

#### 2. Install New Environment

Next, install the new development environment by executing the `install.sh` script. This script will create a Python virtual environment named `venv` in the current directory.

#### 3. Configure New Environment

If the installation process completes successfully, run the `post-runoce.sh` script to complete the environment setup. This will install the `openstackclient` and create the `admin-openrc.sh` file in the `/etc/kolla` directory.

#### 4. Validate Environment

After completing these steps, check the `runonce.log` file for instructions on how to launch a demo Cirros instance.

#### 5. Error Handling

If you encounter any issues during the deployment process, first fix the errors and then use the `reset.sh` script to redeploy the environment.

#### 6. Access OpenStack Dashboard

Finally, you can access the OpenStack dashboard by navigating to [http://5.39.122.88](http://5.39.122.88/).