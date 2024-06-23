{...}: {
  services.openvpn.servers = {
    temp = {
      config = ''config ~/Downloads/temp.ovpn'';
      updateResolvConf = true;
    };
  };
}
