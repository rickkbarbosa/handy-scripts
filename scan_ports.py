#!/usr/bin/env python
# -*- coding: utf-8 -*-

import nmap

input_file="ip.txt"
output_file="scanning_result.csv"
nmap_arguments="-n -sS -T4 -A -v -p 1-100"

''' Parsing ip.txt '''
ip_list = open(input_file, 'r')
hosts = []
nm = nmap.PortScanner()
for linha in ip_list:
    (host, ip) = linha[:-1].split("|")
    hosts.append(ip)

''' Let the games begin '''
hosts = " ".join(hosts)    
scanned_hosts=nm.scan(hosts=hosts, arguments=nmap_arguments)


''' Results '''
output = open(output_file, 'w')
for host in scanned_hosts['scan'].keys():
    try:
        for port in scanned_hosts['scan'][host]['tcp'].keys():
            try:
                state = scanned_hosts['scan'][host]['tcp'][port]['state'],
            except:
                state = ''
            
            try:
                name = scanned_hosts['scan'][host]['tcp'][port]['name']
            except:
                name = ''
            
            try:
                product = scanned_hosts['scan'][host]['tcp'][port]['product']
            except:
                product = ''
            
            try:
                version = scanned_hosts['scan'][host]['tcp'][port]['version']
            except:
                version = ''
            
            try:
                cpe = scanned_hosts['scan'][host]['tcp'][port]['cpe']
            except:
                cpe = ''
            
            try:
                extrainfo = scanned_hosts['scan'][host]['tcp'][port]['extrainfo']
            except:
                extrainfo = ''

            output.write("{};{};{};{};{};{};{};{}\n".format(host, port, state, name, product, version, cpe, extrainfo))

    except:
        pass
    
output.close()