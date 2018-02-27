set emulator_escape "\005"

proc start_salv {} {
    uplevel #0 {spawn ./tools/sims/BIN/ka10 build/sims/init}
    expect "MAGDMP\r\n"; send "l\033ddt\r"
    expect "\n"; send "t\033salv\r"
}

proc start_dskdmp {} {
    quit_emulator
    uplevel #0 {spawn ./tools/sims/BIN/ka10 build/sims/boot}
}

proc mount_tape {file} {
    respond "sim>" "at mta0 $file\r"
    respond "sim>" "c\r"
}

proc create_tape {file} {
    respond "sim>" "at mta0 $file\r"
    respond "sim>" "c\r"
    respond "BUGPC/" "\033P"
}

proc quit_emulator {} {
    respond "sim>" "q\r"
}

proc initialize_comsat {} {
    # commented out because you cannot run COMSAT initialization without network
    # support
    #respond "*" ":job comsat\r"
    #respond "*" ":load .mail.;comsat launch\r"
    #respond "*" "debug/-1\r"
    #type "mfinit\033g"
}

source build/ka10/include.tcl
source build/build.tcl