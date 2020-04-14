<template>
  <v-app id="inspire">
    <v-navigation-drawer
      v-model="sideMenuOpened"
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
      <v-app-bar-nav-icon @click.stop="toggleSideMenu" />
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
                  @change="onCameraToggle"
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
                  @change="onMicToggle"
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
  import { addVolumeLevelListener } from './lib/soundUtils.js'

  export default {
    name: 'AppVue',
    mounted () {
      this.startListeningToMic()
    },
    data () {
      return {
        micLevel: 0,
        sideMenuOpened: false,
        cameraSwitch: true,
        micSwitch: true,
      }
    },
    components: {
      WebCam
    },
    methods: {
      toggleSideMenu () {
        this.sideMenuOpened = !this.sideMenuOpened
      },
      onMicToggle (value) {
        if(value) {
          this.startListeningToMic()
        } else {
          this.stopListeningToMic()
        }
      },
      startListeningToMic () {
        navigator.mediaDevices.getUserMedia({ audio: true, video: false })
                .then(stream => addVolumeLevelListener(stream, this.onMicLevelChange))
      },
      stopListeningToMic () {
        navigator.mediaDevices.getUserMedia({ audio: true, video: false }).then(stream => {
          stream.getAudioTracks().forEach(function(track) {
            track.stop();
          })
        })
      },
      onCameraToggle (value) {
        if(value) {
          this.$refs.webcam.start()
        } else {
          this.$refs.webcam.stop()
        }
      },
      onMicLevelChange (volumeLevel) {
        this.micLevel = volumeLevel
      }
    }
  }
</script>
