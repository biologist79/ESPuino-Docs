# 4 · The battery

ESPuino runs happily off a USB power supply indefinitely – but for mobile use, you need a battery.
Since real safety is at stake with lithium batteries, this gets its own chapter. Please read it
before connecting a battery.

!!! danger "Only use lithium batteries **with a BMS** – otherwise there's a fire risk!"
    **Never** use a lithium battery **without a protection circuit (BMS, Battery Management
    System)**. An unprotected battery can be overcharged or over-discharged and **catch fire**.
    Buy a **ready-made battery pack with an integrated BMS** – there's no room for compromise here.

## LFP or LiPo?

Once that's settled, it's about choosing the type. Both are briefly explained in the
[glossary](../einstieg/was-ist-espuino.md); for the decision itself, this comparison is enough:

| | **LFP (LiFePO₄)** | **LiPo** |
| --- | --- | --- |
| Safety | very safe | noticeably more dangerous |
| Choice of ready-made packs | limited (basically just the one mentioned below) | wide |
| Energy density / runtime | lower | higher |

In short: LFP is the mild-mannered, safer sibling; LiPo is the more compact one with more choice –
but also the one that demands more respect.

## Recommendation: ready-made packs

The simplest and safest option is a ready-made pack from **[Eremit](https://www.eremit.de/)**
(German retailer) – they already have the protection built in and the matching **JST-PH
connector**:

- **LiPo:** from the [3.7 V LiPo range](https://www.eremit.de/c/3-7v-lipo-akkus); around
  **2500 mAh** is a good recommendation.
- **LFP:** the [3.2 V 6000 mAh pack with protection](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker)
  – this is the only size available here.

!!! tip "For DIY builders"
    If you'd rather build your own LFP pack with a protection circuit, there's a guide in the
    forum: [A small self-built LiFePO4 pack with BMS (#1592)](https://forum.espuino.de/t/ein-kleiner-lifepo4-akkupack-mit-schutzschaltung-bms-im-selbstbau/1592)
    (German-language). The same rule applies without exception here: **never without a BMS.**

## Connecting it

The battery type is set on the board via solder bridges – pre-set at the factory according to your
order, changeable later. Details are covered under the
[solder bridges in chapter 5](aufbau.md#die-lotbrucken).

!!! warning "Always check the connector's polarity!"
    Never blindly trust the connector – check the **polarity** against the board's printed labels
    before plugging it in. There have been packs with swapped wiring in the past, and reversed
    polarity can destroy the board. Notes on this are also available at the
    [Eremit pack listing](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker).

## How full is the battery?

ESPuino shows the charge level via the Neopixels and in the web interface. To understand this
properly, it matters **how** that reading is derived: ESPuino measures the **battery voltage** and
infers the charge level from it. That works without any extra hardware, but it has a fundamental
weakness – especially with **LFP**. Its voltage stays nearly constant over much of the discharge
curve (around 3.2 V across a large range of charge), so it only gives a rough idea of how full the
battery really is. With **LiPo**, the discharge curve is steeper, and the estimate is correspondingly
more accurate.

A truly exact reading would require a **coulomb counter** that tracks the actual charge drawn. Such
a component isn't currently built into the Complete – so the charge display remains a
voltage-based estimate, with the imprecision noted above for LFP.

!!! note "While charging"
    If a charge cycle is currently running over USB, the measured voltage is artificially raised
    and therefore not meaningful. A reliable charge-level reading is only available when running
    **purely on the battery**.
