import * as React from 'react'
import { DropdownItem } from 'reactstrap'

import { TimeZone, TimeZoneValue } from '@Types'

interface TimeZonePickerItemProps {
  timeZone: TimeZone,
  onPressTimeZone: (timeZone: TimeZone) => void,
}

export class TimeZonePickerItem extends React.Component<TimeZonePickerItemProps> {
  render() {
    const { timeZone } = this.props

    if (timeZone === TimeZone.UTC) {
      return (
        <React.Fragment>
          <DropdownItem onClick={this._onClick}>
            <span className="text-muted mr-1">UTC {TimeZoneValue[timeZone]}</span>
          </DropdownItem>
          <DropdownItem divider={true} />
        </React.Fragment>
      )
    }

    return (
      <DropdownItem onClick={this._onClick}>
        <span className="text-muted mr-1">{TimeZoneValue[timeZone]}</span>
      </DropdownItem>
    )
  }

  private _onClick = () => {
    const { timeZone, onPressTimeZone } = this.props
    onPressTimeZone(timeZone)
  }
}
