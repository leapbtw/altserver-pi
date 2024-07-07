# Altserver-Pi
AltServer docker container for raspberry pi 4

## Steps
0. **Install `docker` and `docker-compose`**
    - Install [`docker`](https://get.docker.com) and [`docker-compose`](https://docs.docker.com/compose/install/linux/#install-the-plugin-manually)
1. **Clone the Repository**
    ```bash
    git clone https://github.com/leapbtw/altserver-pi.git && cd altserver-pi
    ```

2. **Install Dependencies**
    - Install `libimobiledevice` and `usbmuxd`. Package names may vary between distributions, so please check the appropriate package names for your system.

3. **Pair Your iDevice**
    - Connect your iDevice to your PC and run:
      ```bash
      idevicepair list
      idevicepair pair
      ```

4. **Copy Pairing Files**
    - Copy the `.plist` files to the root of the cloned repository:
      ```bash
      cp /var/lib/lockdown/*.plist .
      ```

5. **Verify Repository Structure**
    - Your folder structure should look something like this:
      ```bash
      $ ls
      docker-compose.yaml  Dockerfile  provision_config  README.md  startup_script.sh
      ```

6. **Set Permissions**
    - Set the necessary permissions for the `provision_config` directory:
      ```bash
      chmod 777 provision_config/
      ```

7. **Start the Docker Container**
    - Start the container using Docker Compose:
      ```bash
      docker compose up
      ```

Now you should be able to use the altserver application on your Raspberry Pi 4.

8. **If you want it to run at startup you could create a systemd service like this**
    - Create a new file for your systemd unit:
      ```bash
      sudo vim /etc/systemd/system/altserver.service
      ```
    - Add the following content to the file, *modifying the paths* as needed:
      ```ini
      [Unit]
      Description=AltServer Service
      Requires=docker.service
      After=docker.service

      [Service]
      Type=oneshot
      RemainAfterExit=yes
      WorkingDirectory=/path/to/your/docker-compose.yml
      ExecStart=/usr/local/bin/docker-compose up
      ExecStop=/usr/local/bin/docker-compose down

      [Install]
      WantedBy=multi-user.target
      ```

# Software used in the docker image

- [AltServer-Linux](https://github.com/NyaMisty/AltServer-Linux)
- [anisette-v3-server](https://github.com/Dadoum/anisette-v3-server)
- [netmuxd](https://github.com/jkcoxson/netmuxd)
- [avahi](https://avahi.org/)
