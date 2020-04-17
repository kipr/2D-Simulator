import * as React from 'react';
import { RobotState } from './RobotState';
import { StyleProps } from './style';
//import { RegisterState } from './RegisterState';

export interface VisualizerProps extends StyleProps {
  robot: RobotState;
  //register: RegisterState;
}

type Props = VisualizerProps;

export class Visualizer extends React.Component<Props> {
  render() {
    const { props } = this;
    const {
      className,
      style,
      robot
      //register
    } = props;
    return (
        <svg width="225" height="135" x="255" y="530" id="demobot">
            <image height="100%" href="static/Demobot-Claw-Up-Closed.png"/>
        </svg>

    )
  }
}