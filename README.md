# Traffic Light Controller FSM (Verilog)

## 📌 Overview

This project implements a **Traffic Light Controller** using a **Finite State Machine (FSM)** in Verilog.

The controller cycles through three states:

* RED
* YELLOW
* GREEN

A simplified output signal is used:

* `signal_out = 1` → Vehicles can **GO** (GREEN)
* `signal_out = 0` → Vehicles must **STOP / WAIT** (RED or YELLOW)

This project is designed for **RTL Design and Verification beginners** to understand FSM design concepts.

---

## ⚙️ Features

* Moore FSM design (output depends only on state)
* Three traffic states: RED → YELLOW → GREEN
* Timer-based state transitions
* Active-low reset (`rst_n`)
* Simplified 1-bit control output

---

## 🧱 State Encoding

| State  | Encoding | Description        |
| ------ | -------- | ------------------ |
| RED    | 2'b00    | Stop vehicles      |
| YELLOW | 2'b01    | Prepare to go/stop |
| GREEN  | 2'b10    | Vehicles can go    |

---

## 🔌 Port Description

### Inputs

| Signal    | Width | Description              |
| --------- | ----- | ------------------------ |
| clk       | 1     | System clock             |
| rst_n     | 1     | Active-low reset         |
| timer_exp | 1     | Timer expiration trigger |

---

### Outputs

| Signal     | Width | Description                     |
| ---------- | ----- | ------------------------------- |
| signal_out | 1     | 1 = GO (GREEN), 0 = STOP / WAIT |

---

## 🔄 State Transition Logic

The FSM transitions based on `timer_exp`:

```
RED    --(timer_exp)--> YELLOW
YELLOW --(timer_exp)--> GREEN
GREEN  --(timer_exp)--> RED
```

If `timer_exp = 0`, the FSM remains in the current state.

---

## 🧠 Output Logic

* Output is based only on the current state (Moore FSM)

| State  | signal_out |
| ------ | ---------- |
| RED    | 0          |
| YELLOW | 0          |
| GREEN  | 1          |

---

## 🧪 Testbench

The testbench:

* Generates a clock signal
* Applies reset
* Toggles `timer_exp` to drive state transitions
* Monitors output using `$monitor`
* Dumps waveform (`.vcd`) for analysis

---

## ▶️ Simulation

### Using Icarus Verilog

```bash id="fsm001"
iverilog -o tlc_fsm tb_tlc_fsm.v tlc_fsm.v
vvp tlc_fsm
gtkwave tlc_fsm.vcd
```

---

## 📊 Expected Behavior

* FSM starts in **RED** after reset
* On each `timer_exp`, state advances
* Output becomes `1` only in **GREEN state**
* Sequence repeats continuously

---

## 🎯 Learning Objectives

* FSM design (Moore machine)
* State encoding and transitions
* Sequential vs combinational logic
* Reset handling in RTL
* Writing simple verification testbenches

---

## 🚀 Possible Extensions

* Add separate outputs for RED/YELLOW/GREEN
* Add pedestrian crossing logic
* Introduce configurable timers
* Add assertions for state checking

---

## 👨‍💻 Author

Devarala Praveen Kumar

---
