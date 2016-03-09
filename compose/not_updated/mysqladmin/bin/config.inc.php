<?php
$cfg['blowfish_secret'] = '';
$cfg['PmaNoRelation_DisableWarning'] = true;
$i = 0;

$i++;
$cfg['Servers'][$i]['extension']     = 'mysqli';
$cfg['Servers'][$i]['host']          = 'mysql';

$i++;
$cfg['Servers'][$i]['extension']     = 'mysqli';
$cfg['Servers'][$i]['host']          = 'adminmysql';
$cfg['Servers'][$i]['auth_type']     = 'config';
$cfg['Servers'][$i]['user']          = 'root';
$cfg['Servers'][$i]['password']      = 'root';
