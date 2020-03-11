import { connect } from 'react-redux'

import { TimeZonePicker } from './TimeZonePicker'
import { selectTimeZone } from './actions'
import { State, TimeZone } from '@Types'

const mapStateToProps = (state: State) => {
  const { selectedTimeZone } = state
  return {
    selectedTimeZone,
  }
}

const mapDispatchToProps = dispatch => ({
  onSelectTimeZone: (timeZone: TimeZone) => dispatch(selectTimeZone(timeZone)),
})

export default connect(mapStateToProps, mapDispatchToProps)(TimeZonePicker)
