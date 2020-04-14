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
              <v-row align="center"
                     justify="center">
                <v-col><v-icon>mdi-microphone</v-icon>Microphone</v-col>
                <v-col>
                  <v-switch
                          v-model="micSwitch"
                          :label="`${micSwitch ? 'On' : 'Off'}`"
                  ></v-switch>
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
    data () {
      return {
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
      }
    }
  }
</script>
