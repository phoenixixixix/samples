import { Action, TimeZone } from '@Types'

export enum Actions {
  TIME_ZONE_SELECT = 'TIME_ZONE_SELECT',
}

export type SelectTimeZoneAction = Action<Actions.TIME_ZONE_SELECT, TimeZone>

export function selectTimeZone(timeZone: TimeZone): SelectTimeZoneAction {
  return {
    type: Actions.TIME_ZONE_SELECT,
    payload: timeZone,
  }
}
