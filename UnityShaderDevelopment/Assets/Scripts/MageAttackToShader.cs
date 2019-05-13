using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MageAttackToShader : StateMachineBehaviour
{
    public Renderer renderer;

    override public void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    {
        renderer = animator.transform.Find("Mage").Find("Mage_Weapon").GetComponentInChildren<Renderer>();
        renderer.material.SetFloat("_MagicMask", 1);
    }
    
    override public void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
    {
        renderer = animator.transform.Find("Mage").Find("Mage_Weapon").GetComponentInChildren<Renderer>();
        renderer.material.SetFloat("_MagicMask", 0);
    }

}
