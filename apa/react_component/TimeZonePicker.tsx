import * as React from 'react'
import { Dropdown, DropdownToggle, DropdownMenu } from 'reactstrap'
import { map } from 'lodash'

import { TimeZone, TimeZoneValue } from '@Types'
import { TimeZonePickerItem } from './TimeZonePickerItem'

interface TimeZonePickerProps {
  selectedTimeZone: TimeZone,
  onSelectTimeZone: (timeZone: TimeZone) => void,
}

interface TimeZonePickerState {
  dropdownOpen: boolean,
}

export class TimeZonePicker extends React.Component<TimeZonePickerProps, TimeZonePickerState> {
  constructor(props) {
    super(props)

    this.state = {
      dropdownOpen: false,
    }
  }

  toggle = () => {
    this.setState(prevState => ({
      dropdownOpen: !prevState.dropdownOpen,
    }))
  }

  render() {
    const { dropdownOpen } = this.state
    const { selectedTimeZone, onSelectTimeZone } = this.props

    return (
      <Dropdown
        isOpen={dropdownOpen}
        toggle={this.toggle}
        className="d-inline-block align-middle mr-3 ml-3"
      >
        <DropdownToggle
          outline={true}
          color="dark"
          size="sm"
          caret={true}
          style={{ height: 52 }}
          test-id="time-zone-menu"
        >
          {TimeZoneValue[selectedTimeZone]}
        </DropdownToggle>
        <DropdownMenu style={{ height: 300, overflowY: 'auto' }}>
          {this.renderTimeZoneItems()}
        </DropdownMenu>
      </Dropdown>
    )
  }

  private renderTimeZoneItems() {
    const { onSelectTimeZone } = this.props

    return map(TimeZone, (timeZone) => {
      return (
        <TimeZonePickerItem
          key={timeZone}
          timeZone={timeZone}
          onPressTimeZone={onSelectTimeZone}
        />
      )
    })
  }
}
