import re
import json


def parse_pactl_output(output):
    modules = []
    current_module = None
    parsing_properties = False

    for line in output.split("\n"):
        if line.startswith("Module #"):
            if current_module:
                modules.append(current_module)
            current_module = {"Properties": {}}
            parsing_properties = False
        elif line.startswith("Properties:"):
            parsing_properties = True
        elif parsing_properties and line.strip():
            key, value = line.strip().split(" = ")
            current_module["Properties"][key] = value
        elif line.strip():
            key, value = re.match(r"\s+(.*):\s(.*)", line).groups()
            current_module[key] = value

    if current_module:
        modules.append(current_module)

    return modules


def convert_to_json(output):
    modules = parse_pactl_output(output)
    return json.dumps(modules, indent=2)


# Example usage:
pactl_output = """
Module #0
	Name: module-device-restore
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Automatically restore the volume/mute state of devices"
		module.version = "16.1"

Module #1
	Name: module-stream-restore
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Automatically restore the volume/mute/device state of streams"
		module.version = "16.1"

Module #2
	Name: module-card-restore
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Automatically restore profile of cards"
		module.version = "16.1"

Module #3
	Name: module-augment-properties
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Augment the property sets of streams with additional static information"
		module.version = "16.1"

Module #4
	Name: module-switch-on-port-available
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "David Henningsson"
		module.description = "Switches ports and profiles when devices are plugged/unplugged"
		module.version = "16.1"

Module #5
	Name: module-udev-detect
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Detect available audio hardware and load matching drivers"
		module.version = "16.1"

Module #6
	Name: module-jackdbus-detect
	Argument: channels=2
	Usage counter: n/a
	Properties:
		module.author = "David Henningsson"
		module.description = "Adds JACK sink/source ports when JACK is started"
		module.version = "16.1"

Module #7
	Name: module-jack-sink
	Argument: connect=yes channels=2
	Usage counter: 1
	Properties:
		module.author = "Lennart Poettering"
		module.description = "JACK Sink"
		module.version = "16.1"

Module #8
	Name: module-jack-source
	Argument: connect=yes channels=2
	Usage counter: 1
	Properties:
		module.author = "Lennart Poettering"
		module.description = "JACK Source"
		module.version = "16.1"

Module #9
	Name: module-dbus-protocol
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Tanu Kaskinen"
		module.description = "D-Bus interface"
		module.version = "16.1"

Module #10
	Name: module-native-protocol-unix
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Native protocol (UNIX sockets)"
		module.version = "16.1"

Module #11
	Name: module-gsettings
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Sylvain Baubeau"
		module.description = "GSettings Adapter"
		module.version = "16.1"

Module #12
	Name: module-default-device-restore
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Automatically restore the default sink and source"
		module.version = "16.1"

Module #13
	Name: module-always-sink
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Colin Guthrie"
		module.description = "Always keeps at least one sink loaded even if it's a null one"
		module.version = "16.1"

Module #14
	Name: module-intended-roles
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Automatically set device of streams based on intended roles of devices"
		module.version = "16.1"

Module #15
	Name: module-suspend-on-idle
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "When a sink/source is idle for too long, suspend it"
		module.version = "16.1"

Module #16
	Name: module-console-kit
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Create a client for each ConsoleKit session of this user"
		module.version = "16.1"

Module #17
	Name: module-systemd-login
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Create a client for each login session of this user"
		module.version = "16.1"

Module #18
	Name: module-position-event-sounds
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Position event sounds between L and R depending on the position on screen of the widget triggering them."
		module.version = "16.1"

Module #19
	Name: module-role-cork
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Lennart Poettering"
		module.description = "Mute & cork streams with certain roles while others exist"
		module.version = "16.1"

Module #20
	Name: module-filter-heuristics
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Colin Guthrie"
		module.description = "Detect when various filters are desirable"
		module.version = "16.1"

Module #21
	Name: module-filter-apply
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Colin Guthrie"
		module.description = "Load filter sinks automatically when needed"
		module.version = "16.1"

Module #22
	Name: module-bluetooth-policy
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "Frédéric Dalleau, Pali Rohár"
		module.description = "Policy module to make using bluetooth devices out-of-the-box easier"
		module.version = "16.1"

Module #23
	Name: module-bluetooth-discover
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "João Paulo Rechi Vita"
		module.description = "Detect available Bluetooth daemon and load the corresponding discovery module"
		module.version = "16.1"

Module #24
	Name: module-bluez5-discover
	Argument: 
	Usage counter: n/a
	Properties:
		module.author = "João Paulo Rechi Vita"
		module.description = "Detect available BlueZ 5 Bluetooth audio devices and load BlueZ 5 Bluetooth audio drivers"
		module.version = "16.1"

Module #25
	Name: module-alsa-card
	Argument: device_id="1" name="usb-ASTRO_Gaming_ASTRO_A30-01" card_name="alsa_card.usb-ASTRO_Gaming_ASTRO_A30-01" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1"
	Usage counter: 0
	Properties:
		module.author = "Lennart Poettering"
		module.description = "ALSA Card"
		module.version = "16.1"

Module #26
	Name: module-alsa-card
	Argument: device_id="2" name="usb-Nuance_PowerMicII-NS-00" card_name="alsa_card.usb-Nuance_PowerMicII-NS-00" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes avoid_resampling=no card_properties="module-udev-detect.discovered=1"
	Usage counter: 0
	Properties:
		module.author = "Lennart Poettering"
		module.description = "ALSA Card"
		module.version = "16.1"

Sink #0
	State: IDLE
	Name: jack_out
	Description: JACK sink (PulseAudio JACK Sink)
	Driver: module-jack-sink.c
	Sample Specification: float32le 2ch 48000Hz
	Channel Map: front-left,front-right
	Owner Module: 7
	Mute: no
	Volume: front-left: 64534 /  98% / -0.40 dB,   front-right: 64534 /  98% / -0.40 dB
	        balance 0.00
	Base Volume: 65536 / 100% / 0.00 dB
	Monitor Source: jack_out.monitor
	Latency: 3416 usec, configured 42666 usec
	Flags: DECIBEL_VOLUME LATENCY 
	Properties:
		device.api = "jack"
		device.description = "JACK sink (PulseAudio JACK Sink)"
		jack.client_name = "PulseAudio JACK Sink"
		device.icon_name = "audio-card"
	Formats:
		pcm

Source #0
	State: RUNNING
	Name: jack_out.monitor
	Description: Monitor of JACK sink (PulseAudio JACK Sink)
	Driver: module-jack-sink.c
	Sample Specification: float32le 2ch 48000Hz
	Channel Map: front-left,front-right
	Owner Module: 7
	Mute: no
	Volume: front-left: 65536 / 100% / 0.00 dB,   front-right: 65536 / 100% / 0.00 dB
	        balance 0.00
	Base Volume: 65536 / 100% / 0.00 dB
	Monitor of Sink: jack_out
	Latency: 0 usec, configured 42666 usec
	Flags: DECIBEL_VOLUME LATENCY 
	Properties:
		device.description = "Monitor of JACK sink (PulseAudio JACK Sink)"
		device.class = "monitor"
		device.icon_name = "audio-input-microphone"
	Formats:
		pcm

Source #1
	State: RUNNING
	Name: jack_in
	Description: JACK source (PulseAudio JACK Source)
	Driver: module-jack-source.c
	Sample Specification: float32le 2ch 48000Hz
	Channel Map: front-left,front-right
	Owner Module: 8
	Mute: no
	Volume: front-left: 65536 / 100% / 0.00 dB,   front-right: 65536 / 100% / 0.00 dB
	        balance 0.00
	Base Volume: 65536 / 100% / 0.00 dB
	Monitor of Sink: n/a
	Latency: 46625 usec, configured 21333 usec
	Flags: DECIBEL_VOLUME LATENCY 
	Properties:
		device.api = "jack"
		device.description = "JACK source (PulseAudio JACK Source)"
		jack.client_name = "PulseAudio JACK Source"
		device.icon_name = "audio-input-microphone"
	Formats:
		pcm

Source Output #1
	Driver: protocol-native.c
	Owner Module: 10
	Client: 22
	Source: 0
	Sample Specification: float32le 1ch 144Hz
	Channel Map: mono
	Format: pcm, format.sample_format = "\"float32le\""  format.rate = "144"  format.channels = "1"  format.channel_map = "\"mono\""
	Corked: no
	Mute: no
	Volume: mono: 65536 / 100% / 0.00 dB
	        balance 0.00
	Buffer Latency: 777 usec
	Source Latency: 0 usec
	Resample method: peaks
	Properties:
		media.name = "Peak detect"
		application.name = "PulseAudio Volume Control"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		application.id = "org.PulseAudio.pavucontrol"
		application.icon_name = "audio-card"
		application.version = "5.0"
		application.process.id = "164651"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pavucontrol"
		application.language = "en_US.UTF-8"
		window.x11.display = ":0"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		module-stream-restore.id = "source-output-by-application-id:org.PulseAudio.pavucontrol"

Source Output #2
	Driver: protocol-native.c
	Owner Module: 10
	Client: 22
	Source: 1
	Sample Specification: float32le 1ch 144Hz
	Channel Map: mono
	Format: pcm, format.sample_format = "\"float32le\""  format.rate = "144"  format.channels = "1"  format.channel_map = "\"mono\""
	Corked: no
	Mute: no
	Volume: mono: 65536 / 100% / 0.00 dB
	        balance 0.00
	Buffer Latency: 1055 usec
	Source Latency: 46645 usec
	Resample method: peaks
	Properties:
		media.name = "Peak detect"
		application.name = "PulseAudio Volume Control"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		application.id = "org.PulseAudio.pavucontrol"
		application.icon_name = "audio-card"
		application.version = "5.0"
		application.process.id = "164651"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pavucontrol"
		application.language = "en_US.UTF-8"
		window.x11.display = ":0"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		module-stream-restore.id = "source-output-by-application-id:org.PulseAudio.pavucontrol"

Client #0
	Driver: module-systemd-login.c
	Owner Module: 17
	Properties:
		application.name = "Login Session 1"
		systemd-login.session = "1"

Client #2
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "i3status-rs_context"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		application.process.id = "1316"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "i3status-rs"
		application.language = "C"
		window.x11.display = ":0"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Client #3
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "Tilda"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.process.id = "1545"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "tilda"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		application.icon_name = "tilda"

Client #4
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "Google Chrome input"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		application.process.id = "80786"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "chrome"
		application.language = "en_US.UTF-8"
		window.x11.display = ":0"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Client #14
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "Tilda"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.process.id = "1441"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "tilda"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		application.icon_name = "tilda"

Client #16
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "keepassxc"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.process.id = "1329"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "keepassxc"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Client #22
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "PulseAudio Volume Control"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		application.id = "org.PulseAudio.pavucontrol"
		application.icon_name = "audio-card"
		application.version = "5.0"
		application.process.id = "164651"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pavucontrol"
		application.language = "en_US.UTF-8"
		window.x11.display = ":0"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Client #23
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "PulseAudio Volume Control"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.display = ":0"
		window.x11.screen = "0"
		application.process.id = "164651"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pavucontrol"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		application.icon_name = "multimedia-volume-control"

Client #281
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "google-chrome"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.process.id = "40189"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "chrome"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Client #291
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "jalv.gtk"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.process.id = "230507"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "jalv.gtk"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Client #299
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "Pulsar"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.process.id = "219337"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pulsar"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		application.icon_name = "pulsar"

Client #308
	Driver: protocol-native.c
	Owner Module: 10
	Properties:
		application.name = "pactl"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		application.process.id = "446981"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pactl"
		application.language = "en_US.UTF-8"
		window.x11.display = ":0"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Sample #0
	Name: audio-volume-change
	Sample Specification: s16le 2ch 44100Hz
	Channel Map: front-left,front-right
	Volume: (invalid)
	        balance 0.00
	Duration: 0.1s
	Size: 11.5 KiB
	Lazy: no
	Filename: n/a
	Properties:
		media.role = "event"
		event.id = "audio-volume-change"
		event.description = "Volume Control Feedback Sound"
		media.name = "audio-volume-change"
		media.filename = "/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"
		application.name = "PulseAudio Volume Control"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.display = ":0"
		window.x11.screen = "0"
		application.process.id = "164651"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pavucontrol"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		application.icon_name = "multimedia-volume-control"

Sample #1
	Name: dialog-error
	Sample Specification: s16le 2ch 44100Hz
	Channel Map: front-left,front-right
	Volume: (invalid)
	        balance 0.00
	Duration: 0.5s
	Size: 86.0 KiB
	Lazy: no
	Filename: n/a
	Properties:
		media.role = "event"
		event.description = "Message dialog shown"
		event.id = "dialog-error"
		media.name = "dialog-error"
		media.filename = "/usr/share/sounds/freedesktop/stereo/dialog-error.oga"
		application.name = "Thunar"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.icon_name = "Thunar"
		application.process.id = "216648"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "thunar"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"

Sample #2
	Name: dialog-information
	Sample Specification: s16le 2ch 44100Hz
	Channel Map: front-left,front-right
	Volume: (invalid)
	        balance 0.00
	Duration: 0.1s
	Size: 10.4 KiB
	Lazy: no
	Filename: n/a
	Properties:
		media.role = "event"
		event.description = "Message dialog shown"
		event.id = "dialog-information"
		media.name = "dialog-information"
		media.filename = "/usr/share/sounds/freedesktop/stereo/dialog-information.oga"
		application.name = "Pulsar"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "35"
		window.x11.screen = "0"
		window.x11.display = ":0"
		application.process.id = "219337"
		application.process.user = "b08x"
		application.process.host = "tinybot"
		application.process.binary = "pulsar"
		application.language = "en_US.UTF-8"
		application.process.machine_id = "b1f39acde3904e16b9beae080eb8b994"
		application.process.session_id = "1"
		application.icon_name = "pulsar"

Card #0
	Name: alsa_card.usb-ASTRO_Gaming_ASTRO_A30-01
	Driver: module-alsa-card.c
	Owner Module: 25
	Properties:
		alsa.card = "1"
		alsa.card_name = "ASTRO A30"
		alsa.long_card_name = "ASTRO Gaming ASTRO A30 at usb-0000:00:14.0-9, full speed"
		alsa.driver_name = "snd_usb_audio"
		device.bus_path = "pci-0000:00:14.0-usb-0:9:1.1"
		sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.1/sound/card1"
		udev.id = "usb-ASTRO_Gaming_ASTRO_A30-01"
		device.bus = "usb"
		device.vendor.id = "9886"
		device.vendor.name = "Astro Gaming"
		device.product.id = "0050"
		device.product.name = "ASTRO A30"
		device.serial = "ASTRO_Gaming_ASTRO_A30"
		device.string = "1"
		device.description = "ASTRO A30"
		module-udev-detect.discovered = "1"
		device.icon_name = "audio-card-usb"
	Profiles:
		input:mono-fallback: Mono Input (sinks: 0, sources: 1, priority: 1, available: yes)
		output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0, priority: 6500, available: yes)
		output:analog-stereo+input:mono-fallback: Analog Stereo Output + Mono Input (sinks: 1, sources: 1, priority: 6501, available: yes)
		output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, sources: 0, priority: 5500, available: yes)
		output:iec958-stereo+input:mono-fallback: Digital Stereo (IEC958) Output + Mono Input (sinks: 1, sources: 1, priority: 5501, available: yes)
		output:iec958-ac3-surround-51: Digital Surround 5.1 (IEC958/AC3) Output (sinks: 1, sources: 0, priority: 300, available: yes)
		output:iec958-ac3-surround-51+input:mono-fallback: Digital Surround 5.1 (IEC958/AC3) Output + Mono Input (sinks: 1, sources: 1, priority: 301, available: yes)
		off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
	Active Profile: off
	Ports:
		analog-input-headset-mic: Headset Microphone (type: Headset, priority: 8800, latency offset: 0 usec, availability unknown)
			Properties:
				device.icon_name = "audio-input-microphone"
			Part of profile(s): input:mono-fallback, output:analog-stereo+input:mono-fallback, output:iec958-stereo+input:mono-fallback, output:iec958-ac3-surround-51+input:mono-fallback
		analog-output: Analog Output (type: Analog, priority: 9900, latency offset: 0 usec, availability unknown)
			Part of profile(s): output:analog-stereo, output:analog-stereo+input:mono-fallback
		iec958-stereo-output: Digital Output (S/PDIF) (type: SPDIF, priority: 0, latency offset: 0 usec, availability unknown)
			Part of profile(s): output:iec958-stereo, output:iec958-stereo+input:mono-fallback

Card #1
	Name: alsa_card.usb-Nuance_PowerMicII-NS-00
	Driver: module-alsa-card.c
	Owner Module: 26
	Properties:
		alsa.card = "2"
		alsa.card_name = "PowerMicII-NS"
		alsa.long_card_name = "Nuance PowerMicII-NS at usb-0000:00:14.0-7.1, full speed"
		alsa.driver_name = "snd_usb_audio"
		device.bus_path = "pci-0000:00:14.0-usb-0:7.1:1.0"
		sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.1/1-7.1:1.0/sound/card2"
		udev.id = "usb-Nuance_PowerMicII-NS-00"
		device.bus = "usb"
		device.vendor.id = "0554"
		device.vendor.name = "Dictaphone Corp."
		device.product.id = "1001"
		device.product.name = "PowerMicII-NS"
		device.serial = "Nuance_PowerMicII-NS"
		device.string = "2"
		device.description = "PowerMicII-NS"
		module-udev-detect.discovered = "1"
		device.icon_name = "audio-card-usb"
	Profiles:
		input:mono-fallback: Mono Input (sinks: 0, sources: 1, priority: 1, available: yes)
		output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0, priority: 6500, available: yes)
		output:analog-stereo+input:mono-fallback: Analog Stereo Output + Mono Input (sinks: 1, sources: 1, priority: 6501, available: yes)
		output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, sources: 0, priority: 5500, available: yes)
		output:iec958-stereo+input:mono-fallback: Digital Stereo (IEC958) Output + Mono Input (sinks: 1, sources: 1, priority: 5501, available: yes)
		output:iec958-ac3-surround-51: Digital Surround 5.1 (IEC958/AC3) Output (sinks: 1, sources: 0, priority: 300, available: yes)
		output:iec958-ac3-surround-51+input:mono-fallback: Digital Surround 5.1 (IEC958/AC3) Output + Mono Input (sinks: 1, sources: 1, priority: 301, available: yes)
		off: Off (sinks: 0, sources: 0, priority: 0, available: yes)
	Active Profile: off
	Ports:
		analog-input-mic: Microphone (type: Mic, priority: 8700, latency offset: 0 usec, availability unknown)
			Properties:
				device.icon_name = "audio-input-microphone"
			Part of profile(s): input:mono-fallback, output:analog-stereo+input:mono-fallback, output:iec958-stereo+input:mono-fallback, output:iec958-ac3-surround-51+input:mono-fallback
		analog-output-speaker: Speakers (type: Speaker, priority: 10000, latency offset: 0 usec, availability unknown)
			Properties:
				device.icon_name = "audio-speakers"
			Part of profile(s): output:analog-stereo, output:analog-stereo+input:mono-fallback
		iec958-stereo-output: Digital Output (S/PDIF) (type: SPDIF, priority: 0, latency offset: 0 usec, availability unknown)
			Part of profile(s): output:iec958-stereo, output:iec958-stereo+input:mono-fallback

"""

json_result = convert_to_json(pactl_output)
print(json_result)
