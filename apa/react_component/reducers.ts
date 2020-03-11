import * as moment from 'moment'

import { Actions, SelectTimeZoneAction } from './actions'
import { TimeZone } from '@Types'

export type TimeZoneReducerState = TimeZone

export const initialState: TimeZoneReducerState = TimeZone.UTC

export default function timeZoneReducer(
  state = initialState,
  action: SelectTimeZoneAction,
): TimeZoneReducerState {
  switch (action.type) {
    case Actions.TIME_ZONE_SELECT: {
      const timeZone = action.payload
      return timeZone
    }

    default: {
      return state
    }
  }
}
