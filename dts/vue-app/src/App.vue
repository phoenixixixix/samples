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

        <v-list-item link>
          <v-list-item-action>
            <v-icon>mdi-contact-mail</v-icon>
          </v-list-item-action>

          <v-list-item-content>
            <v-list-item-title>Contact</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar
      app
      color="cyan"
      dark
    >
      <v-spacer />

      <v-toolbar-title>Application</v-toolbar-title>

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
          <v-row>
            <v-col class="text-center">
              Test my Device
            </v-col>
          </v-row>
          <v-row>
            <v-col>
              <WebCam
                ref="webcam"
                :deviceId="deviceId"
                width="auto"
                height="100%"
                @cameras="onCameras"
                @camera-change="onCameraChange"
                :isFrontCam="frontCam"
              >
              </WebCam>
            </v-col>
            <v-col>
              <v-row>
                <v-switch
                  v-model="cameraSwitch"
                  @change="onCameraSwitch"
                  :label="`Camera: ${cameraSwitch ? 'On' : 'Off'}`"
                ></v-switch>
              </v-row>
              <v-row>
                <v-switch
                  v-model="micSwitch"
                  :label="`Microphone: ${micSwitch ? 'On' : 'Off'}`"
                ></v-switch>
              </v-row>
            </v-col>
          </v-row>
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
        cameraSwitch: true,
        micSwitch: false,
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
      onStart () {
        this.$refs.webcam.start()
      },
      onStop () {
        this.$refs.webcam.stop()
      },
    }
  }
</script>
