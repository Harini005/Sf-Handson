import { LightningElement } from 'lwc';

export default class Stopwatch extends LightningElement {
    initialminutes = 0;
    initialseconds = 0;
    initialHours = 0;
    initialMilliseconds = 0;

    interval;

    get timeRan() {
        let timeStr = (this.initialHours < 10 ? '0' + this.initialHours : this.initialHours);
        timeStr = timeStr + ':' + (this.initialminutes < 10 ? '0' + this.initialminutes : this.initialminutes);
        timeStr = timeStr + ':' + (this.initialseconds < 10 ? '0' + this.initialseconds : this.initialseconds);
        timeStr = timeStr + ':' + (this.initialMilliseconds < 10 ? '0' + this.initialMilliseconds : this.initialMilliseconds);

        return timeStr;
    }

    startCounter() {
        this.interval = setInterval(() => {
            this.initialMilliseconds++;
            if (this.initialMilliseconds < 1000) {
                return;
            }
            this.initialMilliseconds = 0;
            this.initialseconds++;

            if (this.initialseconds < 60) {
                return;
            }
            this.initialminutes++;
            this.initialseconds = 0;
            if (this.initialminutes < 60) {
                return;
            }
            this.initialHours++;
            this.initialminutes = 0;
        }, 1);
    }

    stopCounter() {
        window.clearInterval(this.interval);
    }

    ResetCounter() {
        this.initialMilliseconds = 0;
        this.initialHours = 0;
        this.initialminutes = 0;
        this.initialseconds = 0;
        
    }
}