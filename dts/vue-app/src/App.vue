<template>
  <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      app
      right
    >
      <v-list dense>
        <v-list-item link>
          <v-list-item-action>
            <v-icon>mdi-camera</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>Test My Device</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar
      app
      color="cyan"
      dark
    >
      <v-toolbar-title>Application</v-toolbar-title>
      <v-spacer />
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
    </v-app-bar>

    <v-content>
      <v-container
        class="fill-height"
        fluid
      >
        <v-row
                align="center"
                justify="center"
        >
          <h1>Test my Device</h1>
        </v-row>
        <v-row
          align="center"
          justify="center"
        >
          <v-col>
            <div v-if="cameraSwitch">
              <WebCam
                ref="webcam"
                width="640px"
                height="480px"
                @started="onStarted"
                @stopped="onStopped"
              >
              </WebCam>
            </div>
            <div v-else>
              <img width="640px" height="480px" :src="require('./assets/no-video.svg')">
            </div>
          </v-col>
          <v-col>
            <v-row align="center"
                   justify="center">
              <v-col><v-icon>mdi-camera</v-icon>Camera</v-col>
              <v-col>
                <v-switch
                  v-model="cameraSwitch"
                  @change="onCameraSwitch"
                  :label="`${cameraSwitch ? 'On' : 'Off'}`"
                ></v-switch>
              </v-col>
            </v-row>
            <v-row align="center" justify="center">
              <v-col>
                <v-icon>mdi-microphone</v-icon>Microphone
                <div style="width: 125px">
                  <v-progress-linear :value="micLevel" :active="micSwitch"></v-progress-linear>
                </div>
              </v-col>
              <v-col>
                <v-switch
                        v-model="micSwitch"
                        @change="onMicSwitch"
                        :label="`${micSwitch ? 'On' : 'Off'}`"
                ></v-switch>
              </v-col>
            </v-row>
            <v-row align="center" justify="center">
              <v-col>
                <v-row>
                  <v-col>
                    <v-icon>mdi-wifi</v-icon>Connectivity
                  </v-col>
                </v-row>
                <v-row>
                  <v-col>
                    <div style="width: 100%">
                      <v-progress-linear :value="0"></v-progress-linear>
                    </div>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
            <v-row align="center">
              <v-col>
                <v-btn :block="true">Run Test</v-btn>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-container>
    </v-content>

    <v-footer
      color="cyan"
      app
    >
      <v-spacer />

      <span class="white--text">&copy; 2020</span>
    </v-footer>
  </v-app>
</template>

<script>
  import { WebCam } from 'vue-cam-vision'
  export default {
    name: 'AppVue',
    mounted () {
      navigator.mediaDevices.getUserMedia({ audio: true, video: false })
              .then(this.getMicLevel.bind(this, this))
    },
    data () {
      return {
        micLevel: 0,
        drawer: false,
        cameraSwitch: true,
        micSwitch: true,
        cameraStarted: false,
        captures: [],
        imgReport: [],
        frontCam: false,
        webcam: null,
        img: null,
        camera: null,
        deviceId: null,
        devices: []
      }
    },
    components: {
      WebCam
    },
    methods: {
      onMicSwitch (value) {
        if(value) {
          navigator.mediaDevices.getUserMedia({ audio: true, video: false }).then(this.getMicLevel.bind(this, this))
        } else {
          navigator.mediaDevices.getUserMedia({ audio: true, video: false }).then(stream => {
            stream.getAudioTracks().forEach(function(track) {
              track.stop();
            })
          })
        }
      },
      onCameraSwitch (value) {
        if(value) {
          this.$refs.webcam.start()
        } else {
          this.$refs.webcam.stop()
        }
      },
      onStarted () {
        this.cameraStarted = true
      },
      onStopped () {
        this.cameraStarted = false
      },
      getMicLevel (self, stream) {
        let audioContext = new AudioContext();
        let analyser = audioContext.createAnalyser();
        let microphone = audioContext.createMediaStreamSource(stream);
        let javascriptNode = audioContext.createScriptProcessor(2048, 1, 1);

        analyser.smoothingTimeConstant = 0.8;
        analyser.fftSize = 1024;

        microphone.connect(analyser);
        analyser.connect(javascriptNode);
        javascriptNode.connect(audioContext.destination);
        javascriptNode.onaudioprocess = function() {
          var array = new Uint8Array(analyser.frequencyBinCount);
          analyser.getByteFrequencyData(array);
          var values = 0;

          var length = array.length;
          for (var i = 0; i < length; i++) {
            values += (array[i]);
          }

          var average = values / length;

          self.micLevel = Math.round(average)
          // console.log('this.micLevel', this.micLevel)
          // console.log(Math.round(average));
          // colorPids(average);
        }
      }
    }
  }
</script>
