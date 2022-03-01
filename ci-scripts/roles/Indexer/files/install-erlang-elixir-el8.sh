#!/bin/sh
# This file can be used as an auto installer or you can mannually execute the steps yourself.
# If you use it as an installer, you must run it as root.

# Check if the script is run with sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run as root or with sudo"
  exit
else
  echo "Installing Erlang and Elixir..."
fi

# Install epel-release and enable PowerTools
dnf install -y epel-release
dnf config-manager --set-enabled PowerTools

# Create work dir
mkdir erliex && cd erliex

# Download and install erlang repo
curl -LO https://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm
dnf install -y erlang-solutions-2.0-1.noarch.rpm

# Install erlang along with some useful packages (some of them are needed for elixir)
dnf install -y esl-erlang unzip

# Download the precompiled release from elixir's github repo
# You can use this url https://github.com/elixir-lang/elixir/releases
# Or you can use the command below and just change v.1.10.3 to the version you need
curl -LO https://github.com/elixir-lang/elixir/releases/download/v1.13.3/Precompiled.zip

# Extract elixir and move it to the appropriate location
unzip Precompiled.zip
cp -rf bin/* /usr/bin/
cp -rf lib/* /lib/
cp -rf man/* /usr/share/man/

# Remove leftover files
cd .. && rm -rf erliex/

# Exit message
echo "Instalation complete!"